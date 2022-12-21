import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/entities/entities.dart';
import '../../../resources/resources.dart';
import '../../../theme/app_colors.dart';

class GridModel extends StatefulWidget {
  const GridModel({super.key, required this.state});

  final Results? state;

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
            child: Image.network(
              '${widget.state?.image}',
              fit: BoxFit.cover,
              errorBuilder: (context, object, trace) {
                return Image.asset(Images.imageError2);
              },
            ),
          ),
          const SizedBox(height: 18),
          Text(
            '${widget.state?.status}',
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                letterSpacing: 1.5,
                color: statusColor(widget.state?.status ?? ''),
              ),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 20,
            width: 164,
            child: AutoSizeText(
              '${widget.state?.name}',
              minFontSize: 1,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: AppColors.colorFFFFFF,
                ),
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${widget.state?.species}, ${widget.state?.gender}',
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
