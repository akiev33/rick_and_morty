import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../resources/resources.dart';
import '../../../theme/app_colors.dart';
import '../../cubit/cubit.dart';

class CharacterModel extends StatefulWidget {
  const CharacterModel({super.key, required this.index, required this.state});

  final UserState state;
  final int index;

  @override
  State<CharacterModel> createState() => _CharacterModelState();
}

class _CharacterModelState extends State<CharacterModel> {
  getColors(String text) {
    if (text == 'Alive') {
      return AppColors.color43D049;
    }
    if (text == 'unknown') {
      return AppColors.colorGrey;
    } else {
      return AppColors.colorEB5757;
    }
  }

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
          child: Image.network(
            '${widget.state.user?.results?[widget.index].image}',
            fit: BoxFit.cover,
            errorBuilder: (context, object, trace) {
              return Image.asset(Images.imageError2);
            },
          ),
        ),
        const SizedBox(width: 18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.state.user?.results?[widget.index].status}',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  letterSpacing: 1.5,
                  color: getColors(
                      '${widget.state.user?.results?[widget.index].status}'),
                ),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 20,
              width: MediaQuery.of(context).size.width * 0.7,
              child: AutoSizeText(
                '${widget.state.user?.results?[widget.index].name}',
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
            const SizedBox(height: 5),
            Text(
              '${widget.state.user?.results?[widget.index].species}, ${widget.state.user?.results?[widget.index].gender}',
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
}
