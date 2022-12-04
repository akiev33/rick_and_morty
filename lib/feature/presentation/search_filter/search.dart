import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../resources/svgIcons.dart';
import '../../../theme/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {},
      controller: _controller,
      style: TextStyle(color: AppColors.colorFFFFFF),
      decoration: InputDecoration(
        filled: true,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 0.0),
          borderRadius: BorderRadius.all(
            Radius.circular(100.0),
          ),
        ),
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
          borderSide: BorderSide(width: 0.0),
          borderRadius: BorderRadius.all(
            Radius.circular(100.0),
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