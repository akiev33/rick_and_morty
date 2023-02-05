import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/feature/presentation/setting_screen/profile_editing/profile_editing.dart';
import 'package:rick_and_morty/resources/resources.dart';
import 'package:rick_and_morty/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as l;

import '../../../theme/theme_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late final SharedPreferences prefs;
  int groupValue = 0;
  List<String> infomation = ['No infomation', 'No login'];
  ValueNotifier<String> theme = ValueNotifier('Включено');

  @override
  void initState() {
    initPrefs();
    super.initState();
  }

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    infomation =
        prefs.getStringList('infomation') ?? ['No infomation', 'No login'];
    groupValue = prefs.getInt('radioButtonValue') ?? 0;
    setState(() {});
  }

  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      // final imageTemporary = File(image.path);
      final imagePermanent = await saveImagePermanently(image.path);
      setState(() => this.image = imagePermanent);
    } on PlatformException catch (e) {
      print('Failed to pick Image - $e');
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = l.basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(imagePath);
  }

  @override
  void dispose() {
    theme.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            const SizedBox(
              width: 6,
            ),
            Text(
              'Настройки',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  color: context.watch<ThemeProvider>().colorInText,
                  letterSpacing: 0.15,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Column(
              children: [
                const SizedBox(height: 25),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      foregroundImage: FileImage(
                        File(prefs.getString('avatars') ?? ''),
                      ),
                      child: Image.asset(
                        Images.avatars,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          infomation[0],
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.15,
                              color: context.watch<ThemeProvider>().colorInText,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          infomation[1],
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
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileEditing(),
                        ),
                      ).then(
                        (value) async {
                          infomation = value;
                          prefs.setStringList('infomation', infomation);
                          setState(() {});
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                      side: BorderSide(color: AppColors.color22A2BD),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    child: Text(
                      'Редактировать',
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
              ],
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  color: context.watch<ThemeProvider>().colorDividerHorizontal,
                  thickness: 1,
                ),
                const SizedBox(height: 36),
                Text(
                  'ВНЕШНИЙ ВИД',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: AppColors.color5B6975,
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: context
                              .watch<ThemeProvider>()
                              .colorButtonNavigationBar,
                          title: Text(
                            'Темная тема',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.15,
                                color:
                                    context.watch<ThemeProvider>().colorInText,
                              ),
                            ),
                          ),
                          content: StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return SizedBox(
                                height: 120,
                                width: 310,
                                child: Column(
                                  children: [
                                    _myRadioButton(
                                      title: 'Включено',
                                      value: 0,
                                      groupValue: groupValue,
                                      onChanged: (val) async {
                                        theme.value = 'Включено';
                                        setState(() {
                                          groupValue = val ?? 0;
                                        });
                                        prefs.setInt(
                                          'radioButtonValue',
                                          groupValue,
                                        );
                                        context
                                            .read<ThemeProvider>()
                                            .changeTheme(isDark: true);
                                        await prefs.setBool('theme', true);
                                      },
                                    ),
                                    _myRadioButton(
                                      title: 'Выключено',
                                      value: 1,
                                      groupValue: groupValue,
                                      onChanged: (val) async {
                                        theme.value = 'Выключено';
                                        setState(() {
                                          groupValue = val ?? 0;
                                        });
                                        prefs.setInt(
                                          'radioButtonValue',
                                          groupValue,
                                        );
                                        context
                                            .read<ThemeProvider>()
                                            .changeTheme(isDark: false);
                                        prefs.setBool('theme', false);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                color: context
                                    .watch<ThemeProvider>()
                                    .colorButtonNavigationBar,
                                padding: const EdgeInsets.all(14),
                                child: Text(
                                  'Отмена',
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: context
                                          .watch<ThemeProvider>()
                                          .colorInText,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/colorPalette.svg',
                        height: 36,
                        width: 36,
                        color: context.watch<ThemeProvider>().colorInText,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Темная тема',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                color:
                                    context.watch<ThemeProvider>().colorInText,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                letterSpacing: 0.15,
                              ),
                            ),
                          ),
                          ValueListenableBuilder(
                              valueListenable: theme,
                              builder: (context, _, __) {
                                return Text(
                                  theme.value,
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      color: AppColors.color6E798C
                                          .withOpacity(0.60),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      letterSpacing: 0.25,
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                      const SizedBox(width: 224),
                      Icon(
                        Icons.navigate_next,
                        color: context.watch<ThemeProvider>().colorInText,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),
                Divider(
                  color: context.watch<ThemeProvider>().colorDividerHorizontal,
                  thickness: 1,
                ),
                const SizedBox(height: 36),
                Text(
                  'О ПРИЛОЖЕНИИ',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: AppColors.color5B6975,
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Зигерионцы помещают Джерри и Рика в симуляцию, чтобы узнать секрет изготовления концен-трированной темной материи.',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.25,
                      color: context.watch<ThemeProvider>().colorInText,
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                Divider(
                  color: context.watch<ThemeProvider>().colorDividerHorizontal,
                  thickness: 1,
                ),
                const SizedBox(height: 36),
                Text(
                  'ВЕРСИЯ ПРИЛОЖЕНИЯ',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: AppColors.color5B6975,
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Rick & Morty  v1.0.0',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.25,
                      fontWeight: FontWeight.w400,
                      color: context.watch<ThemeProvider>().colorInText,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _myRadioButton({
    required String title,
    required int value,
    required int groupValue,
    required void Function(int?)? onChanged,
  }) {
    return RadioListTile(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      title: Text(
        title,
        style: GoogleFonts.roboto(
          textStyle: TextStyle(
            color: context.watch<ThemeProvider>().colorInText,
            fontWeight: FontWeight.w400,
            fontSize: 16,
            letterSpacing: 0.15,
          ),
        ),
      ),
    );
  }
}
