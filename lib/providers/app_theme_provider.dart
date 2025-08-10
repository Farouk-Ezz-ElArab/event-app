import 'package:event_app/utils/app_consts.dart';
import 'package:flutter/material.dart';

import '../core/shared_preference.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appTheme;

  AppThemeProvider({this.appTheme = ThemeMode.light});

  void changeTheme(ThemeMode newTheme) async {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    final SharedPreference prefs = SharedPreference();
    await prefs.saveData(
      AppConsts.themeKey,
      appTheme == ThemeMode.dark
          ? AppConsts.darkThemeString
          : AppConsts.lightThemeString,
    );
    notifyListeners();
  }
}
