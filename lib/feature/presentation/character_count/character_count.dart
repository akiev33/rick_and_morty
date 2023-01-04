import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../resources/svgIcons.dart';
import '../../../theme/app_colors.dart';

class CharacterCount extends StatefulWidget {
  const CharacterCount({
    super.key,
    required this.countInCharacter,
    required this.someFunc,
  });

  final int? countInCharacter;
  final Function(bool value) someFunc;

  @override
  State<CharacterCount> createState() => _CharacterCountState();
}

class _CharacterCountState extends State<CharacterCount> {
  bool isChange = true;

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
              'ВСЕГО ПЕРСОНАЖЕЙ: ${(widget.countInCharacter ?? 0).toString()}',
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
            onPressed: () {
              widget.someFunc(isChange = !isChange);
              setState(() {});
            },
            icon: SvgPicture.asset(
              (isChange) ? forCube : threeLines,
              height: 26,
              width: 26,
            ),
          ),
        ),
      ],
    );
  }
}
