import 'package:evently_app/core/app_colors.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsItem extends StatelessWidget {
  String text;
  Widget item;

  SettingsItem({super.key, required this.text, required this.item});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    bool isDark = themeProvider.isDarkMode();
    var width = MediaQuery.of(context).size.width ;
    var height = MediaQuery.of(context).size.width ;



    return Container(
      padding: EdgeInsets.symmetric(horizontal:width*0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),

        border: Border.all(
          color: isDark ? AppColors.strokeDarkColor : AppColors.greyColor,
          width: 1,
        ),
        color: isDark ? AppColors.transparent : AppColors.strokeColor,
      ),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: Theme.of(context).textTheme.headlineSmall),
          item,
        ],
      ),
    );
  }
}
