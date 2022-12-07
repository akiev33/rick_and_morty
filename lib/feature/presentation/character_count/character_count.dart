import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../resources/svgIcons.dart';
import '../../../theme/app_colors.dart';

class CharacterCount extends StatelessWidget {
  const CharacterCount({super.key, required this.countInCharacter});

  final int? countInCharacter;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 24,
          width: 170,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              'ВСЕГО ПЕРСОНАЖЕЙ: ${(countInCharacter ?? 0).toString()}',
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
    );
  }
}
