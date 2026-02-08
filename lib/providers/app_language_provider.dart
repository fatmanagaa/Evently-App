

import 'package:flutter/material.dart';

class AppLanguageProvider extends ChangeNotifier {
  //todo: this class is observable
  //todo: put in it data that change then notify other observers
  //todo: function that change this data
  String appLanguage = 'en';

  void changeLanguage(String newLang) {

    if (appLanguage == newLang) {
      return;
    }
    appLanguage = newLang;

    notifyListeners();
    //todo: notify all observers when the data change send to all observers notification
  }
  }
