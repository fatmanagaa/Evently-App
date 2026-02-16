import 'package:evently_app/core/app_assets.dart';
import 'package:evently_app/core/app_style.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app_colors.dart';
import '../../../../../core/extensions/context_extensions.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final themeProvider = context.theme;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width*0.01),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.01,
      ),
      height: height * 0.15,
      decoration: BoxDecoration(
        color: context.isDark ? AppColors.bgDarkMode : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(AppAssets.birthday),
        ),
        border: Border.all(
          color: context.isDark ? AppColors.transparent : AppColors.stroke,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.01,
            ),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: context.isDark ? AppColors.mainDarkMode : AppColors.white,
              border: Border.all(
                color: context.isDark
                    ? AppColors.transparent
                    : AppColors.stroke,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                '21 Jan',
                style: context.isDark
                    ? AppStyles.medium16MainDark
                    : AppStyles.medium16Main,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.01,
            ),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: context.isDark ? AppColors.mainDarkMode : AppColors.white,
              border: Border.all(
                color: context.isDark
                    ? AppColors.transparent
                    : AppColors.stroke,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Text(
                    'This is a Birthday Party ',
                    style: context.isDark
                        ? AppStyles.medium16MainDark
                        : AppStyles.medium16Main,
                  ),
                ),
                IconButton(onPressed: (){
                  //todo:add to favorite
                },icon: Icon(
                  Icons.favorite_border_outlined,
                  color: context.isDark
                      ? AppColors.main
                      : AppColors.mainDarkMode,
                ),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
