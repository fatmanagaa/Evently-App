import 'package:evently_app/core/app_colors.dart';
import 'package:evently_app/core/app_style.dart';
import 'package:evently_app/core/extensions/context_extensions.dart';
import 'package:evently_app/features/home_screen/tabs/home/widgets/event_item.dart';
import 'package:evently_app/features/home_screen/tabs/home/widgets/tab_widget.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

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
        toolbarHeight: height * 0.12,
        centerTitle: false,
        backgroundColor: context.isDark ? AppColors.mainDarkMode : AppColors.main,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.welcome_back,
              style: AppStyles.regular14White,
            ),
            Text(
              AppLocalizations.of(context)!.user_name,
              style: AppStyles.semiBold24White,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          SizedBox(
            height: 50,
            child: DefaultTabController(
              length: eventsNameList.length,
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                onTap: (index) {
                  selectedIndex = index;
                  setState(() {});
                },
                tabs: eventsNameList.asMap().entries.map((entry) {
                  int idx = entry.key;
                  String eventName = entry.value;
                  return TabWidget(
                    isSelected: selectedIndex == idx,
                    selectedColor: context.isDark ? AppColors.mainDarkMode : AppColors.main,
                    unSelectedColor: Colors.transparent,
                    eventsName: eventName,
                    selectedTextStyle: AppStyles.medium16White,
                    unSelectedTextStyle: context.isDark ? AppStyles.medium16White : AppStyles.medium16Main,
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return EventItem();
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 16);
              },
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
