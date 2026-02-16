import 'package:evently_app/core/app_colors.dart';
import 'package:evently_app/core/app_style.dart';
import 'package:evently_app/core/extensions/context_extensions.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/screens/home_screen/tabs/home/widgets/event_item.dart';
import 'package:evently_app/screens/home_screen/tabs/home/widgets/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/app_theme_provider.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;
  List<String> eventsNameList = [];

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final themeProvider = context.theme;
    final languageProvider = context.language;

    eventsNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sports,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.welcome_back,
              style: AppStyles.regular14Grey,
            ),
            SizedBox(height: 3),
            Text(
              AppLocalizations.of(context)!.user_name,
              style: AppStyles.semi20Black,
            ),
          ],
        ),
        actions: [
          Icon(
            themeProvider.isDarkMode()
                ? Icons.dark_mode
                : Icons.light_mode_outlined,
            color: themeProvider.isDarkMode()
                ? AppColors.mainDarkMode
                : AppColors.main,
          ),
          Container(
            width: 34,
            height: 32,
            margin: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.005,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.005,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.isDark ? AppColors.mainDarkMode : AppColors.main,
            ),
            child: Center(
              child: Text(
                context.language.appLanguage.toUpperCase(),
                style: AppStyles.regular14White,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: height * 0.015,

            decoration: BoxDecoration(
              color: AppColors.mainText,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DefaultTabController(
              length: eventsNameList.length,
              child: TabBar(
                tabAlignment: TabAlignment.start,
                labelPadding: EdgeInsets.symmetric(horizontal: width * 0.02),
                indicatorColor: Colors.transparent,
                dividerColor: AppColors.transparent,
                labelColor: Colors.transparent,
                unselectedLabelColor: Colors.transparent,
                onTap: (index) {
                  selectedIndex = index;
                  setState(() {});
                },

                isScrollable: true,
                indicator: BoxDecoration(color: Colors.transparent),

                tabs: eventsNameList.map((eventName) {
                  return TabWidget(
                    isSelected:
                        selectedIndex == eventsNameList.indexOf(eventName),
                    selectedColor: context.isDark
                        ? AppColors.mainDarkMode
                        : AppColors.main,
                    unSelectedColor: AppColors.transparent,
                    eventsName: eventName,
                    selectedTextStyle: AppStyles.medium16White,
                    unSelectedTextStyle: context.isDark
                        ? AppStyles.medium16White
                        : AppStyles.medium16Black,
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return EventItem();
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
