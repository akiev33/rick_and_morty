import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/feature/presentation/setting_screen/NSF_editing/nsf_editing.dart';
import 'package:rick_and_morty/feature/presentation/setting_screen/login/login_editing.dart';
import 'package:rick_and_morty/resources/resources.dart';
import 'package:rick_and_morty/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEditing extends StatefulWidget {
  const ProfileEditing({super.key});

  @override
  State<ProfileEditing> createState() => _ProfileEditingState();
}

class _ProfileEditingState extends State<ProfileEditing> {
  late final SharedPreferences prefs;
  String name = '';
  String surname = '';
  String patronymic = '';
  String login = '';

  @override
  void initState() {
    initPrefs();
    super.initState();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? '';
    surname = prefs.getString('surname') ?? '';
    patronymic = prefs.getString('patronymic') ?? '';
    login = prefs.getString('login') ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          splashRadius: 25,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Редактировать профиль',
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CircleAvatar(
                radius: 75,
                child: Image.asset(
                  Images.avatars,
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                log('изменить фото');
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Изменить фото',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.15,
                      color: AppColors.color22A2BD,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'ПРОФИЛЬ',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                  color: AppColors.color5B6975,
                ),
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NfsEditing(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Изменить ФИО',
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.15,
                            color: AppColors.colorFFFFFF,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      AutoSizeText(
                        '''$surname $name $patronymic''',
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.25,
                            color: AppColors.color6E798C.withOpacity(0.60),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.navigate_next,
                    color: AppColors.colorFFFFFF,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginEditing(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Логин',
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.15,
                            color: AppColors.colorFFFFFF,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        login,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.25,
                            color: AppColors.color6E798C.withOpacity(0.60),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.navigate_next,
                    color: AppColors.colorFFFFFF,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
