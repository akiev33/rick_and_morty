import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_and_morty/theme/app_colors.dart';

import '../../resources/svgIcons.dart';

class ButtonNavigationBar extends StatefulWidget {
  const ButtonNavigationBar({super.key});

  @override
  State<ButtonNavigationBar> createState() => _ButtonNavigationBarState();
}

class _ButtonNavigationBarState extends State<ButtonNavigationBar> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.color152A3A,
      selectedItemColor: AppColors.color43D049,
      unselectedItemColor: AppColors.color5B6975,
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(
          label: 'Персонажи',
          icon: SvgPicture.asset(
            ghost,
            height: selectedIndex == 0 ? 25 : 22,
            color: selectedIndex == 0 ? AppColors.color43D049 : null,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Локациии',
          icon: SvgPicture.asset(
            planet,
            height: selectedIndex == 1 ? 23 : 20,
            color: selectedIndex == 1
                ? AppColors.color43D049
                : AppColors.color5B6975,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Эпизоды',
          icon: SvgPicture.asset(
            tv,
            height: selectedIndex == 2 ? 23 : 20,
            color: selectedIndex == 2
                ? AppColors.color43D049
                : AppColors.color5B6975,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Настройки',
          icon: SvgPicture.asset(
            settings,
            height: selectedIndex == 3 ? 25 : 22,
            color: selectedIndex == 3
                ? AppColors.color43D049
                : AppColors.color5B6975,
          ),
        ),
      ],
    );
  }
}
