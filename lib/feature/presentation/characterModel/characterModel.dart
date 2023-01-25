import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/theme/theme_provider.dart';

import '../../../theme/app_colors.dart';

class CharacterModel extends StatefulWidget {
  const CharacterModel({
    super.key,
    required this.image,
    required this.status,
    required this.name,
    required this.species,
    required this.gender,
  });

  final String image;
  final String status;
  final String name;
  final String species;
  final String gender;

  @override
  State<CharacterModel> createState() => _CharacterModelState();
}

class _CharacterModelState extends State<CharacterModel> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          height: 74,
          width: 74,
          alignment: Alignment.center,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: CachedNetworkImage(
            imageUrl: widget.image,
            fit: BoxFit.cover,
            placeholder: (context, url) => CircularProgressIndicator.adaptive(
              backgroundColor: AppColors.color43D049,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        const SizedBox(width: 18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.status,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  letterSpacing: 1.5,
                  color: statusColor(widget.status),
                ),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 20,
              width: MediaQuery.of(context).size.width * 0.7,
              child: AutoSizeText(
                widget.name,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    color: context.watch<ThemeProvider>().colorInText,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${widget.species}, ${widget.gender}',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                  color: AppColors.color6E798C,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color statusColor(String text) {  
    switch (text) {
      case 'Dead':
        return AppColors.colorEB5757;
      case 'Alive':
        return AppColors.color43D049;
      default:
        return AppColors.colorGrey;
    }
  }
}
