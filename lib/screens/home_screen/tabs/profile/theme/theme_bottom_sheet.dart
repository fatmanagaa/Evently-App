import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../../providers/app_language_provider.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var appThemeProvider = Provider.of<AppThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.04),
      child: Column(
        spacing: height*0.02,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: (){
              //todo:change theme to dark
              appThemeProvider.changeTheme(ThemeMode.dark);
            },
            child: appThemeProvider.isDarkMode()?
                getSelectedItemWidget(theme: AppLocalizations.of(context)!.dark):
                getUnSelectedItemWidget(theme: AppLocalizations.of(context)!.dark)
            ,

          ),

          InkWell(
              onTap: (){
                //todo:change theme to light
                appThemeProvider.changeTheme(ThemeMode.light);
              },
            child: appThemeProvider.isLightMode()?
                getSelectedItemWidget(theme: AppLocalizations.of(context)!.light):
                getUnSelectedItemWidget(theme: AppLocalizations.of(context)!.light)
            ,


          )],
      ),
    );
  }
  Widget getSelectedItemWidget({required String theme}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(theme),
        Icon(Icons.check)
      ],
    );
  }
  Widget getUnSelectedItemWidget({required String theme}){
    return Text(theme );
  }




}

