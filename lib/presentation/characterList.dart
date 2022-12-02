import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/presentation/buttonNavigationBar/buttonNavigationBar.dart';
import 'package:rick_and_morty/theme/app_colors.dart';

import '../resources/svgIcons.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({super.key});

  @override
  State<CharacterList> createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const ButtonNavigationBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              TextField(
                onChanged: (value) {},
                controller: _controller,
                style: TextStyle(color: AppColors.colorFFFFFF),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.color152A3A,
                  hintText: 'Найти персонажа',
                  hintStyle: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: AppColors.color5B6975,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.44,
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 30,
                          child: VerticalDivider(
                            width: 1,
                            color: AppColors.colorFFFFFF.withOpacity(0.40),
                          ),
                        ),
                        IconButton(
                          splashRadius: 0.1,
                          onPressed: () {
                            log('suffixIcon button');
                          },
                          icon: SvgPicture.asset(
                            searchIcon,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Icon(
                      Icons.search,
                      size: 26,
                      color: AppColors.color5B6975,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(100.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 24,
                    width: 170,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'ВСЕГО ПЕРСОНАЖЕЙ: 200',
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5,
                            color: AppColors.color5B6975,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        forCube,
                        height: 26,
                        width: 26,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
