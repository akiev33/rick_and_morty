import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/feature/presentation/setting_screen/profile_editing/profile_editing.dart';
import 'package:rick_and_morty/resources/resources.dart';
import 'package:rick_and_morty/theme/app_colors.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
                  color: AppColors.colorFFFFFF,
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
                      child: Image.asset(Images.avatars),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Oleg Belotserkovsky',
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.15,
                              color: AppColors.colorFFFFFF,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Rick',
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
                  color: AppColors.color152A3A,
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
                        int groupValue = 0;
                        return AlertDialog(
                          backgroundColor: AppColors.color152A3A,
                          title: Text(
                            'Темная тема',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.15,
                                color: AppColors.colorFFFFFF,
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
                                      onChanged: (val) => setState(
                                        () => groupValue = val ?? 0,
                                      ),
                                    ),
                                    _myRadioButton(
                                      title: 'Выключено',
                                      value: 1,
                                      groupValue: groupValue,
                                      onChanged: (val) => setState(
                                        () => groupValue = val ?? 0,
                                      ),
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
                                color: AppColors.color152A3A,
                                padding: const EdgeInsets.all(14),
                                child: Text(
                                  'Отмена',
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.colorFFFFFF,
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
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Темная тема',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                color: AppColors.colorFFFFFF,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                letterSpacing: 0.15,
                              ),
                            ),
                          ),
                          Text(
                            'Включена',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                color: AppColors.color6E798C.withOpacity(0.60),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                letterSpacing: 0.25,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 224),
                      Icon(
                        Icons.navigate_next,
                        color: AppColors.colorFFFFFF,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),
                Divider(
                  color: AppColors.color152A3A,
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
                      color: AppColors.colorFFFFFF,
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                Divider(
                  color: AppColors.color152A3A,
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
                      color: AppColors.colorFFFFFF,
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
          color: AppColors.colorFFFFFF,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          letterSpacing: 0.15,
        ),
      ),
    ),
  );
}
