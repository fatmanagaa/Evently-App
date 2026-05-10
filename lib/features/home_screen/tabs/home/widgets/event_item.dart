import 'package:evently_app/core/app_assets.dart';
import 'package:evently_app/core/app_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../core/app_colors.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../providers/event_list_provider.dart';

class EventItem extends StatelessWidget {
  final Event event;
  
  const EventItem({
    super.key,
    required this.event,
  });

  /// Get category image based on category name
  String _getCategoryImage(BuildContext context) {
    switch (event.category.toLowerCase()) {
      case 'book club':
        return AppAssets.getBookClubImage(context);
      case 'sports':
        return AppAssets.getSportImage(context);
      case 'birthday':
        return AppAssets.getBirtDayImage(context);
      case 'meeting':
        return AppAssets.getMeetingImage(context);
      case 'exhibition':
        return AppAssets.getExhibitionImage(context);
      default:
        return AppAssets.birthday;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final eventProvider = Provider.of<EventListProvider>(context, listen: false);
    
    // Format the date to show day and month
    final dayFormat = DateFormat('dd');
    final monthFormat = DateFormat('MMM');
    final day = dayFormat.format(event.date);
    final month = monthFormat.format(event.date);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: 8),
      height: height * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(_getCategoryImage(context)),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.7), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: context.isDark ? AppColors.mainDarkMode : AppColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$day\n$month',
                textAlign: TextAlign.center,
                style: context.isDark ? AppStyles.medium18mainDark : AppStyles.medium18main,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.isDark ? AppColors.mainDarkMode : AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          event.title,
                          style: context.isDark ? AppStyles.medium16Black : AppStyles.medium16Black,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${event.time.hour.toString().padLeft(2, '0')}:${event.time.minute.toString().padLeft(2, '0')}',
                          style: AppStyles.regular14Grey,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      eventProvider.toggleFavorite(event);
                    },
                    child: Icon(
                      event.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: context.isDark ? AppColors.mainDarkMode : AppColors.main,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
