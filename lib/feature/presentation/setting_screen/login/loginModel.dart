import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../theme/app_colors.dart';

class LoginModel extends StatefulWidget {
  const LoginModel({
    super.key,
    required this.controller,
    required this.fullName,
  });

  final TextEditingController controller;
  final String fullName;

  @override
  State<LoginModel> createState() => _LoginModelState();
}

class _LoginModelState extends State<LoginModel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.fullName,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25,
              color: AppColors.colorFFFFFF,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.fullName,
            hintStyle: GoogleFonts.roboto(
              textStyle: TextStyle(
                color: AppColors.color5B6975,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
              ),
            ),
            fillColor: AppColors.color152A3A,
            filled: true,
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.color152A3A),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.color152A3A),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
              color: AppColors.colorFFFFFF,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}
