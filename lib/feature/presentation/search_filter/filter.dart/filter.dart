import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/resources/svgIcons.dart';
import 'package:rick_and_morty/theme/app_colors.dart';
import 'package:rick_and_morty/theme/theme_provider.dart';

class Filters extends StatefulWidget {
  const Filters({super.key});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  int? id;
  int number = 0;
  List status = [
    {
      "id": 0,
      "value": false,
      "title": "Живой",
    },
    {
      "id": 1,
      "value": false,
      "title": "Мертвый",
    },
    {
      "id": 2,
      "value": false,
      "title": "Неизвестно",
    },
  ];
  List gender = [
    {
      "id": 0,
      "value": false,
      "title": "Мужской",
    },
    {
      "id": 1,
      "value": false,
      "title": "Женский",
    },
    {
      "id": 2,
      "value": false,
      "title": "Бесполый",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Container(
              color: context.watch<ThemeProvider>().colorButtonNavigationBar,
              height: 60,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      splashRadius: 1,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: context.watch<ThemeProvider>().colorInText,
                      ),
                    ),
                    Text(
                      'Фильтры',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.15,
                          color: context.watch<ThemeProvider>().colorInText,
                        ),
                      ),
                    ),
                    const SizedBox(width: 180),
                    IconButton(
                      splashRadius: 1,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: SvgPicture.asset(
                        searchIconBack,
                        color: AppColors.colorEB5757,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    'Сортировать',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                        color: AppColors.color5B6975,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'По алфавиту ',
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.15,
                            color: context.watch<ThemeProvider>().colorInText,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            splashRadius: 1,
                            onPressed: () {
                              number = 0;
                              setState(() {});
                            },
                            icon: SvgPicture.asset(
                              sortAB,
                              color: number == 0
                                  ? AppColors.color22A2BD
                                  : AppColors.color5B6975,
                            ),
                          ),
                          IconButton(
                            splashRadius: 1,
                            onPressed: () {
                              number = 1;
                              setState(() {});
                            },
                            icon: SvgPicture.asset(
                              sortBA,
                              color: number == 1
                                  ? AppColors.color22A2BD
                                  : AppColors.color5B6975,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Divider(
                    color:
                        context.watch<ThemeProvider>().colorDividerHorizontal,
                    thickness: 1,
                  ),
                  const SizedBox(height: 36),
                  Text(
                    'Статус',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                        color: AppColors.color5B6975,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      status.length,
                      (index) => CheckboxListTile(
                        activeColor: AppColors.color22A2BD,
                        controlAffinity: ListTileControlAffinity.leading,
                        value: status[index]['value'],
                        onChanged: (value) {
                          setState(() {
                            for (var element in status) {
                              element['value'] = false;
                            }
                            status[index]['value'] = value;
                          });
                        },
                        title: Text(
                          status[index]['title'],
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              letterSpacing: 0.15,
                              color: context.watch<ThemeProvider>().colorInText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Divider(
                    color:
                        context.watch<ThemeProvider>().colorDividerHorizontal,
                    thickness: 1,
                  ),
                  const SizedBox(height: 35),
                  Text(
                    'Пол',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                        color: AppColors.color5B6975,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Column(
                    children: List.generate(
                      gender.length,
                      (index) => CheckboxListTile(
                        activeColor: AppColors.color22A2BD,
                        controlAffinity: ListTileControlAffinity.leading,
                        value: gender[index]['value'],
                        onChanged: (value) {
                          setState(() {
                            for (var element in gender) {
                              element['value'] = false;
                            }
                            gender[index]['value'] = value;
                          });
                        },
                        title: Text(
                          gender[index]['title'],
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              letterSpacing: 0.15,
                              color: context.watch<ThemeProvider>().colorInText,
                            ),
                          ),
                        ),
                      ),
                    ),
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

// class StatusWidget extends StatefulWidget {
//   const StatusWidget({
//     super.key,
//     required this.text,
//     required this.id,
//   });

//   final String text;
//   final int? id;

//   @override
//   State<StatusWidget> createState() => _StatusWidgetState();
// }

// class _StatusWidgetState extends State<StatusWidget> {
//   bool isChecked = false;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Checkbox(
//           value: isChecked,
//           onChanged: (bool? value) {
//             if (widget.id == 1) {
//               isChecked = value!;
//             }
//             if (widget.id == 2) {
//               isChecked = value!;
//             }
//             if (widget.id == 3) {
//               isChecked = value!;
//             }
//             if (widget.id == 4) {
//               isChecked = value!;
//             }
//             if (widget.id == 5) {
//               isChecked = value!;
//             }
//             if (widget.id == 6) {
//               isChecked = value!;
//             }
//             setState(() {});
//           },
//         ),
        // Text(
        //   widget.text,
        //   style: GoogleFonts.roboto(
        //     textStyle: TextStyle(
        //       fontWeight: FontWeight.w400,
        //       fontSize: 16,
        //       letterSpacing: 0.15,
        //       color: AppColors.colorFFFFFF,
        //     ),
        //   ),
        // ),
//       ],
//     );
//   }
// }
