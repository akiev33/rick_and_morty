import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/feature/presentation/setting_screen/NSF_editing/fullNameModel.dart';
import 'package:rick_and_morty/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NfsEditing extends StatefulWidget {
  const NfsEditing({super.key});

  @override
  State<NfsEditing> createState() => _NfsEditingState();
}

class _NfsEditingState extends State<NfsEditing> {
  late final SharedPreferences prefs;
  bool check = true;
  late final _name = TextEditingController();
  late final _surname = TextEditingController();
  late final _patronymic = TextEditingController();

  @override
  void initState() {
    initPrefs();
    super.initState();
  }

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    _name.text = prefs.getString('name') ?? '';
    _surname.text = prefs.getString('surname') ?? '';
    _patronymic.text = prefs.getString('patronymic') ?? '';
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
              check
                  ? 'empty'
                  : '${_name.text} ${_surname.text} ${_patronymic.text}',
            );
            await prefs.setString('name', _name.text);
            await prefs.setString('surname', _surname.text);
            await prefs.setString('patronymic', _patronymic.text);
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
          'Изменить ФИО',
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
            FullNameModel(
              controller: _name,
              fullName: 'Имя',
            ),
            const SizedBox(height: 10),
            FullNameModel(
              controller: _surname,
              fullName: 'Фамилия',
            ),
            const SizedBox(height: 10),
            FullNameModel(
              controller: _patronymic,
              fullName: 'Отчество',
            ),
          ],
        ),
      ),
    );
  }

  emptyCheck() {
    if (_name.text.isEmpty &&
        _surname.text.isEmpty &&
        _patronymic.text.isEmpty) {
      return check = true;
    } else {
      return check = false;
    }
  }
}
