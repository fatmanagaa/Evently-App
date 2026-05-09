import 'package:evently_app/core/utils/app_assets.dart';
import 'package:evently_app/core/utils/app_style.dart';
import 'package:evently_app/model/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/extensions/context_extensions.dart';

class EventItem extends StatelessWidget {
  final Event event;

  const EventItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: 8),
      height: height * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(event.eventImage),
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
                color: context.isDark
                    ? AppColors.mainDarkMode
                    : AppColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                DateFormat('dd/MM/yyyy').format(event.eventDate),

                textAlign: TextAlign.center,
                style: context.isDark
                    ? AppStyles.medium18mainDark
                    : AppStyles.medium18main,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.isDark
                    ? AppColors.mainDarkMode
                    : AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      event.eventTitle,
                      style: context.isDark
                          ? AppStyles.medium16Black
                          : AppStyles.medium16Black,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.favorite_border,
                    color: context.isDark
                        ? AppColors.mainDarkMode
                        : AppColors.main,
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
