import 'package:evently_app/core/utils/app_colors.dart';
import 'package:evently_app/core/extensions/context_extensions.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_style.dart';
import '../../widgets/custom_text_field.dart';
import '../home/widgets/event_item.dart';

class FavouriteTab extends StatelessWidget {
  const FavouriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final theme = context.theme;
    return SafeArea(
      child: Scaffold(
      
        body: Column(
          children: [
            CustomTextField(
              borderColor: context.isDark
                  ? AppColors.mainDarkMode
                  : AppColors.transparent,
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
            SizedBox(height: 15,),
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
      ),
    );
  }
}
