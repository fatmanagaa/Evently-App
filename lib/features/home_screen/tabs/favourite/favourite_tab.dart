import 'package:evently_app/core/app_colors.dart';
import 'package:evently_app/core/extensions/context_extensions.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_style.dart';
import '../../../../providers/event_list_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../home/widgets/event_item.dart';

class FavouriteTab extends StatefulWidget {
  const FavouriteTab({super.key});

  @override
  State<FavouriteTab> createState() => _FavouriteTabState();
}

class _FavouriteTabState extends State<FavouriteTab> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventListProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              CustomTextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                borderColor: context.isDark
                    ? AppColors.mainDarkMode
                    : AppColors.main,
                filled: true,
                fillColor: context.isDark
                    ? AppColors.mainDarkColor_2
                    : AppColors.white,
                hintText: AppLocalizations.of(context)!.search_event,
                hintStyle: AppStyles.regular14Grey,
                suffixIcon: Icon(
                  Icons.search,
                  color: context.isDark ? AppColors.mainDarkMode : AppColors.main,
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: StreamBuilder<List<Event>>(
                  stream: eventProvider.getFavoriteEventsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    final favorites = snapshot.data ?? [];
                    
                    // Filter by search query
                    final filteredFavorites = favorites.where((event) {
                      return event.title.toLowerCase().contains(searchQuery.toLowerCase());
                    }).toList();

                    if (filteredFavorites.isEmpty) {
                      return Center(
                        child: Text(
                          searchQuery.isEmpty 
                            ? 'No favorite events yet' 
                            : 'No events match your search',
                          style: context.isDark ? AppStyles.medium16White : AppStyles.medium16Black,
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemBuilder: (context, index) {
                        return EventItem(event: filteredFavorites[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                      itemCount: filteredFavorites.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
