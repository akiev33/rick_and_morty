import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../resources/resources.dart';
import '../../../theme/app_colors.dart';
import '../../cubit/cubit.dart';

class GridModel extends StatefulWidget {
  const GridModel({super.key, required this.index, required this.state});

  final UserState state;
  final int index;

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
              '${widget.state.user?.results?[widget.index].image}',
              fit: BoxFit.cover,
              errorBuilder: (context, object, trace) {
                return Image.asset(Images.imageError2);
              },
            ),
          ),
          const SizedBox(height: 18),
          Text(
            '${widget.state.user?.results?[widget.index].status}',
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  letterSpacing: 1.5,
                  color: context.read<UserCubit>().getColors(widget.index)),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 20,
            width: 164,
            child: AutoSizeText(
              '${widget.state.user?.results?[widget.index].name}',
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
    );
  }
}
