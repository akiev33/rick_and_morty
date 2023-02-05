import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/feature/presentation/search_filter/filter.dart/filter.dart';
import 'package:rick_and_morty/theme/theme_provider.dart';

import '../../../resources/svgIcons.dart';
import '../../../theme/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
    required this.onSearch,
    required this.status,
    required this.gender,
  });

  final Function(String name) onSearch;
  final Function(String status, int statusId) status;
  final Function(String gender, int genderId) gender;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (e) {
        widget.onSearch(_controller.text);
      },
      controller: _controller,
      style: TextStyle(color: AppColors.colorFFFFFF),
      decoration: InputDecoration(
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.0,
            color: context.watch<ThemeProvider>().colorBorderInSearch,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(100.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.0,
            color: context.watch<ThemeProvider>().colorBorderInSearch,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(100.0),
          ),
        ),
        fillColor: context.watch<ThemeProvider>().colorInSearch,
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
                  color: context.watch<ThemeProvider>().colorDivider,
                ),
              ),
              IconButton(
                splashRadius: 0.1,
                onPressed: () {
                  Navigator.of(context).push(
                    _createRoute(
                      widget.status,
                      widget.gender,
                    ),
                  );
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

Route _createRoute(final Function(String status, int statusId) status,
    final Function(String gender, int genderId) gender) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Filters(
      status: status,
      gender: gender,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
