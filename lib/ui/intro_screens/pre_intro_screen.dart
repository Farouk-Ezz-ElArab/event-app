import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/utils/app_routes.dart';
import 'package:event_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../providers/app_language_provider.dart';
import '../../providers/app_theme_provider.dart';

class PreIntroScreen extends StatelessWidget {
  const PreIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: screenSize.height * 0.02),
              Image.asset(AppAssets.topLogo),
              Image.asset(AppAssets.beforeIntro),
              SizedBox(height: screenSize.height * 0.04),
              Text(AppLocalizations.of(context)!.personalize,
                  style: AppStyles.bold20Primary),
              SizedBox(height: screenSize.height * 0.03),
              Text(
                AppLocalizations.of(context)!.choose,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium,
              ),
              SizedBox(height: screenSize.height * 0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.language,
                      style: AppStyles.medium20Primary),
                  ToggleSwitch(
                    changeOnTap: true,
                    customWidgets: [
                      Image.asset(AppAssets.enIcon),
                      Image.asset(AppAssets.egIcon),
                    ],
                    radiusStyle: true,
                    curve: Curves.fastLinearToSlowEaseIn,
                    animate: true,
                    minWidth: screenSize.width * 0.2,
                    minHeight: screenSize.width * 0.1,
                    initialLabelIndex: languageProvider.appLanguage == 'en'
                        ? 0
                        : 1,
                    cornerRadius: screenSize.width * 0.5,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.transparent,
                    inactiveFgColor: Colors.white,
                    totalSwitches: 2,
                    borderColor: [AppColors.primaryLight],
                    dividerColor: Colors.transparent,
                    activeBgColors: [
                      [Colors.blue, Colors.lightBlueAccent],
                      [Colors.red, Colors.black],
                    ],
                    onToggle: (index) {
                      if (index == 0) {
                        languageProvider.changeLanguage('en');
                      } else if (index == 1) {
                        languageProvider.changeLanguage('ar');
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.theme,
                      style: AppStyles.medium20Primary),
                  ToggleSwitch(
                    changeOnTap: true,
                    customWidgets: [
                      Image.asset(AppAssets.lightIcon),
                      Image.asset(AppAssets.darkIcon),
                    ],
                    radiusStyle: true,
                    curve: Curves.fastLinearToSlowEaseIn,
                    animate: true,
                    minWidth: screenSize.width * 0.2,
                    minHeight: screenSize.width * 0.1,
                    initialLabelIndex: themeProvider.appTheme == ThemeMode.light
                        ? 0
                        : 1,
                    cornerRadius: screenSize.width * 0.5,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.transparent,
                    inactiveFgColor: Colors.white,
                    totalSwitches: 2,
                    borderColor: [AppColors.primaryLight],
                    dividerColor: Colors.transparent,
                    activeBgColors: [
                      [Colors.blue, Colors.lightBlueAccent],
                      [Colors.red, Colors.black],
                    ],
                    onToggle: (index) {
                      if (index == 0) {
                        themeProvider.changeTheme(ThemeMode.light);
                      } else if (index == 1) {
                        themeProvider.changeTheme(ThemeMode.dark);
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.05),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        vertical: 16
                    ),
                    backgroundColor: AppColors.primaryLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    )
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(
                      AppRoutes.introScreenRouteName);
                },
                child: Text(AppLocalizations.of(context)!.lets,
                    style: AppStyles.medium20White),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

