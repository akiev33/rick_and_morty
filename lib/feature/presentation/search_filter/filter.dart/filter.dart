import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/resources/svgIcons.dart';
import 'package:rick_and_morty/theme/app_colors.dart';

class Filters extends StatefulWidget {
  const Filters({super.key});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  bool isChecked = false;
  int number = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Container(
              color: AppColors.color152A3A,
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
                        Icons.arrow_downward_sharp,
                        color: AppColors.colorFFFFFF,
                      ),
                    ),
                    Text(
                      'Фильтры',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.15,
                          color: AppColors.colorFFFFFF,
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
                            color: AppColors.colorFFFFFF,
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
                    color: AppColors.color152A3A,
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
                    children: [
                      StatusWidget(
                        text: 'Живой',
                        isChecked: isChecked,
                      ),
                      StatusWidget(
                        text: 'Мертвый',
                        isChecked: isChecked,
                      ),
                      StatusWidget(
                        text: 'Неизвестно',
                        isChecked: isChecked,
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Divider(
                    color: AppColors.color152A3A,
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
                  StatusWidget(
                    text: 'Мужской',
                    isChecked: isChecked,
                  ),
                  StatusWidget(
                    text: 'Женский',
                    isChecked: isChecked,
                  ),
                  StatusWidget(
                    text: 'Бесполый',
                    isChecked: isChecked,
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

class StatusWidget extends StatefulWidget {
  StatusWidget({super.key, required this.isChecked, required this.text});

  final String text;
  bool isChecked = false;

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.isChecked,
          onChanged: (bool? value) {
            setState(() {
              widget.isChecked = value!;
            });
          },
        ),
        Text(
          widget.text,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              letterSpacing: 0.15,
              color: AppColors.colorFFFFFF,
            ),
          ),
        ),
      ],
    );
  }
}
