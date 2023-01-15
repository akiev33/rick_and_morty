import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/theme/theme_provider.dart';

import '../../../theme/app_colors.dart';

class GridModel extends StatefulWidget {
  const GridModel({
    super.key,
    required this.name,
    required this.gender,
    required this.image,
    required this.species,
    required this.status,
  });

  final String image;
  final String status;
  final String name;
  final String species;
  final String gender;

  @override
  State<GridModel> createState() => _GridModelState();
}

class _GridModelState extends State<GridModel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 192,
      width: 164,
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            height: 122,
            width: 120,
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
          const SizedBox(height: 18),
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
          const SizedBox(height: 4),
          SizedBox(
            height: 20,
            width: 164,
            child: AutoSizeText(
              widget.name,
              minFontSize: 1,
              maxLines: 2,
              textAlign: TextAlign.center,
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
          const SizedBox(height: 2),
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
