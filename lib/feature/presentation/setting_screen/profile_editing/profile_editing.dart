import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/feature/presentation/setting_screen/NSF_editing/nsf_editing.dart';
import 'package:rick_and_morty/feature/presentation/setting_screen/login/login_editing.dart';
import 'package:rick_and_morty/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

import '../../../../resources/resources.dart';
import '../../../../theme/theme_provider.dart';

class ProfileEditing extends StatefulWidget {
  const ProfileEditing({super.key});

  @override
  State<ProfileEditing> createState() => _ProfileEditingState();
}

class _ProfileEditingState extends State<ProfileEditing> {
  late final SharedPreferences prefs;
  String login = 'no login';
  String fullName = 'no information';

  @override
  void initState() {
    initPrefs();
    super.initState();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    fullName = prefs.getString('fullName') ?? 'no information';
    login = prefs.getString('login') ?? 'no login';
    setState(() {});
  }

  File? _image;

  Future pickImage(ImageSource source) async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final Directory directory = await getApplicationDocumentsDirectory();
      final fileName = basename(image.path);
      final File newImage =
          await File(image.path).copy('${directory.path}/$fileName');
      setState(() {
        _image = newImage;
      });
      prefs.setString('avatars', _image!.path);
    } on PlatformException catch (e) {
      print('Failed to pick Image - $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          splashRadius: 25,
          onPressed: () {
            Navigator.pop(context, <String>[fullName, login]);
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
                foregroundImage: FileImage(
                  File(prefs.getString('avatars') ?? ''),
                ),
                child: Image.asset(
                  Images.avatars,
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: context
                          .watch<ThemeProvider>()
                          .colorButtonNavigationBar,
                      content: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return SizedBox(
                            height: 100,
                            width: 200,
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () =>
                                      pickImage(ImageSource.camera),
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () =>
                                      pickImage(ImageSource.gallery),
                                  child: const Icon(
                                    Icons.image_outlined,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
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
                ).then((value) {
                  if (value != null) {
                    prefs.setString('fullName', value);
                    fullName = value;
                  }
                  log(fullName.toString());
                  setState(() {});
                });
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
                      Text(
                        fullName,
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
                ).then(
                  (value) {
                    if (value != null) {
                      login = value;
                      prefs.setString('login', login);
                    }
                    log(login.toString());
                    setState(() {});
                  },
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
