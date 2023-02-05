import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/feature/presentation/episods/episods_list.dart';
import 'package:rick_and_morty/feature/presentation/location/location_list.dart';
import 'package:rick_and_morty/feature/presentation/setting_screen/setting_screen.dart';
import 'package:rick_and_morty/theme/app_colors.dart';
import 'package:rick_and_morty/theme/theme_provider.dart';

import '../../../resources/svgIcons.dart';
import '../characterList.dart';

class ButtonNavigationBar extends StatefulWidget {
  const ButtonNavigationBar({super.key});

  @override
  State<ButtonNavigationBar> createState() => _ButtonNavigationBarState();
}

class _ButtonNavigationBarState extends State<ButtonNavigationBar> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    if (selectedIndex == index) return;
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: const [
          CharacterList(),
          LocationList(),
          EpisodsList(),
          SettingScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            context.watch<ThemeProvider>().colorButtonNavigationBar,
        selectedItemColor:
            context.watch<ThemeProvider>().colorButtonNavigationIcons,
        unselectedItemColor: AppColors.color5B6975,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            label: 'Персонажи',
            icon: SvgPicture.asset(
              settings,
              height: selectedIndex == 0 ? 25 : 23,
              color: selectedIndex == 0
                  ? context.watch<ThemeProvider>().colorButtonNavigationIcons
                  : null,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Локациии',
            icon: SvgPicture.asset(
              planet,
              height: selectedIndex == 1 ? 23 : 20,
              color: selectedIndex == 1
                  ? context.watch<ThemeProvider>().colorButtonNavigationIcons
                  : AppColors.color5B6975,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Эпизоды',
            icon: SvgPicture.asset(
              tv,
              height: selectedIndex == 2 ? 23 : 20,
              color: selectedIndex == 2
                  ? context.watch<ThemeProvider>().colorButtonNavigationIcons
                  : AppColors.color5B6975,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Настройки',
            icon: SvgPicture.asset(
              ghost,
              height: selectedIndex == 3 ? 25 : 23,
              color: selectedIndex == 3
                  ? context.watch<ThemeProvider>().colorButtonNavigationIcons
                  : AppColors.color5B6975,
            ),
          ),
        ],
      ),
    );
  }
}
