import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/feature/presentation/setting_screen/login/loginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../theme/app_colors.dart';

class LoginEditing extends StatefulWidget {
  const LoginEditing({super.key});

  @override
  State<LoginEditing> createState() => _LoginEditingState();
}

class _LoginEditingState extends State<LoginEditing> {
  late final SharedPreferences prefs;
  late final _login = TextEditingController();
  bool check = true;

  @override
  void initState() {
    initPrefs();
    super.initState();
  }

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    _login.text = prefs.getString('login2') ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 28),
        child: ElevatedButton(
          onPressed: () async {
            emptyCheck();
            Navigator.pop(
              context,
              check ? 'no login' : _login.text,
            );
            prefs.setString('login2', _login.text);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.color22A2BD,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // <-- Radius
            ),
          ),
          child: const Center(
            child: Text(
              'Сохранить',
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          splashRadius: 25,
        ),
        title: Text(
          'Изменить логин',
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.15,
              color: AppColors.colorFFFFFF,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            const SizedBox(height: 60),
            LoginModel(
              controller: _login,
              fullName: 'Логин',
            ),
          ],
        ),
      ),
    );
  }

  emptyCheck() {
    if (_login.text.isEmpty) {
      return check = true;
    } else {
      return check = false;
    }
  }
}
