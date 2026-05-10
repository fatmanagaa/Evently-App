import 'package:evently_app/core/app_colors.dart';
import 'package:evently_app/core/app_style.dart';
import 'package:evently_app/core/extensions/context_extensions.dart';
import 'package:evently_app/features/home_screen/tabs/home/widgets/event_item.dart';
import 'package:evently_app/features/home_screen/tabs/home/widgets/tab_widget.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/event_list_provider.dart';

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

    final eventCategories = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sports,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
    ];

    // Get current user for filtering
    final currentUser = FirebaseAuth.instance.currentUser;
    
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
      body: DefaultTabController(
        length: eventCategories.length,
        child: Column(
          children: [
            SizedBox(height: 16),
            SizedBox(
              height: 50,
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                onTap: (index) {
                  selectedIndex = index;
                  setState(() {});
                },
                tabs: eventCategories.asMap().entries.map((entry) {
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
            Expanded(
              child: Consumer<EventListProvider>(
                builder: (context, eventProvider, _) {
                  // Determine which stream to use
                  Stream<List<Event>> getEventStream() {
                    if (selectedIndex == 0) {
                      // All events
                      return eventProvider.getEventsStream(userId: currentUser?.uid);
                    } else {
                      // Events by category
                      final category = eventCategories[selectedIndex];
                      return eventProvider.getEventsByCategoryStream(
                        category,
                        userId: currentUser?.uid,
                      );
                    }
                  }

                  return StreamBuilder<List<Event>>(
                    stream: getEventStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.main,
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 48,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Error loading events',
                                style: AppStyles.medium16Black,
                              ),
                              SizedBox(height: 8),
                              Text(
                                snapshot.error.toString(),
                                style: AppStyles.regular14Grey,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      final events = snapshot.data ?? [];

                      if (events.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.event_note,
                                color: AppColors.lightGrey,
                                size: 48,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'No events found',
                                style: AppStyles.medium16Black,
                              ),
                              SizedBox(height: 8),
                              Text(
                                selectedIndex == 0
                                    ? 'Create your first event'
                                    : 'No events in this category',
                                style: AppStyles.regular14Grey,
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.separated(
                        padding: EdgeInsets.all(16),
                        itemBuilder: (context, index) {
                          return EventItem(event: events[index]);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 16);
                        },
                        itemCount: events.length,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
