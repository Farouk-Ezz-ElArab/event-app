import 'package:event_app/utils/app_consts.dart';
import 'package:flutter/material.dart';

import '../core/shared_preference.dart';

class AppLanguageProvider extends ChangeNotifier{
  String appLanguage;

  AppLanguageProvider({this.appLanguage = 'en'});

  void changeLanguage(String newLanguage) async {
    if(appLanguage == newLanguage){
      return;
    }
    appLanguage = newLanguage;
    final SharedPreference prefs = SharedPreference();
    await prefs.saveData(AppConsts.languageKey, appLanguage);
    //final String? action = prefs.getString('language');
    notifyListeners();
  }
}