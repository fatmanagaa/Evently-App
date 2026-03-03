import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/screens/home_screen/tabs/favourite/favourite_tab.dart';
import 'package:evently_app/screens/home_screen/tabs/home/home_tab.dart';
import 'package:evently_app/screens/home_screen/tabs/profile/profile_tab.dart';
import 'package:flutter/material.dart';

import '../../core/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabsList = [HomeTab(), FavouriteTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },

        items: [
          buildBottomNavigationBarItem(
            unSelctedIcon:  Icon(Icons.home_outlined),
            label: AppLocalizations.of(context)!.home,
            index: 0,
            selectedIcon: Icon(Icons.home)
          ),
          buildBottomNavigationBarItem(
            selectedIcon: Icon(Icons.favorite_outlined),
            label: AppLocalizations.of(context)!.favourite,
            unSelctedIcon: Icon(Icons.favorite),
            index: 1,
          ),
          buildBottomNavigationBarItem(
            selectedIcon: Icon(Icons.person_outlined),
            label: AppLocalizations.of(context)!.profile,
            unSelctedIcon: Icon(Icons.person),
            index: 2,
          ),
        ],
      ),

      body: tabsList[selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addEventScreen);
        },
        child: Icon(Icons.add, size: 30),
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required Widget selectedIcon,
    required String label,
    required Widget unSelctedIcon,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: selectedIndex == index ? selectedIcon : unSelctedIcon,
      label: label,
    );
  }
}
