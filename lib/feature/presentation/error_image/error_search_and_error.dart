import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../resources/resources.dart';
import '../../../theme/app_colors.dart';

class ErrorImage extends StatelessWidget {
  const ErrorImage({super.key, required this.error});

  final String? error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          if (error == 'Http status error [404]')
            Column(
              children: [
                const SizedBox(height: 120),
                Image.asset(
                  Images.searchError,
                  scale: 4,
                ),
                const SizedBox(height: 28),
                Text(
                  '''Персонаж с таким именем\nне найден''',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.15,
                      color: AppColors.color5B6975,
                    ),
                  ),
                ),
              ],
            ),
          if (error != 'Http status error [404]')
            Column(
              children: [
                Image.asset(
                  Images.ogyr4ikRick,
                  scale: 5,
                ),
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: AutoSizeText(
                    '$error',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.colorFFFFFF.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
