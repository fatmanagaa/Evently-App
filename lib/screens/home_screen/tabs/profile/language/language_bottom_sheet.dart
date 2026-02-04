import 'package:evently_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/app_language_provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
var height = MediaQuery.of(context).size.height;
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.04),
      child: Column(
        spacing: height*0.02,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: (){
              //todo:change language to english
              appLanguageProvider.changeLanguage('en');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.english),
                Icon(Icons.check)
              ],
            ),
          ),

          InkWell(
              onTap: (){
                //todo:change language to arabic
                appLanguageProvider.changeLanguage('ar');
              },
              child: Text(AppLocalizations.of(context)!.arabic)),

        ],
      ),
    );
  }
}
