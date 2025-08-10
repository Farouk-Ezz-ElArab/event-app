import 'package:event_app/ui/home/tabs/profile_tab/language/language_bottom_sheet.dart';
import 'package:event_app/ui/home/tabs/profile_tab/theme/theme_bottom_sheet.dart';
import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_language_provider.dart';
import '../../../../providers/app_theme_provider.dart';
import '../../../../utils/app_colors.dart';
import '../../widgets/custom_elevated_button.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var screenSize = MediaQuery.of(context).size;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        toolbarHeight: screenSize.height * 0.2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(70)
          )
        ),
        backgroundColor: AppColors.primaryLight,
        title: Row(
          children: [
            Image.asset(AppAssets.routeImageRounded),
            SizedBox(width: screenSize.width * 0.03,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Farouk Ezz El-Arab', style: AppStyles.bold24White,),
                SizedBox(height: screenSize.height * 0.01,),
                Text('faroukezz9595@gmail.com', style: AppStyles.medium16White,)
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.04,
          vertical: screenSize.height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.02,
                vertical: screenSize.height * 0.012,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primaryLight, width: 2),
              ),
              child: InkWell(
                onTap: () {
                  showLanguageBottomSheet();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      languageProvider.appLanguage == 'en'
                          ? AppLocalizations.of(context)!.english
                          : AppLocalizations.of(context)!.arabic,
                      style: AppStyles.bold20Primary,
                    ),
                    //Spacer(),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 35,
                      color: AppColors.primaryLight,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              AppLocalizations.of(context)!.theme,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.02,
                vertical: screenSize.height * 0.012,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primaryLight, width: 2),
              ),
              child: InkWell(
                onTap: () {
                  showThemeBottomSheet();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      themeProvider.appTheme == ThemeMode.light
                          ? AppLocalizations.of(context)!.light
                          : AppLocalizations.of(context)!.dark,
                      style: AppStyles.bold20Primary,
                    ),
                    //Spacer(),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 35,
                      color: AppColors.primaryLight,
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            CustomElevatedButton(
              borderColor: AppColors.redColor,
              rowMainAxesAlignment: MainAxisAlignment.start,
              leadingIcon: Icon(
                  Icons.logout, color: AppColors.whiteColor, size: 30),
              buttonTextStyle: AppStyles.regular20White,
              buttonColor: AppColors.redColor,
              buttonText: AppLocalizations.of(
                context,
              )!.logout,
              onPressed: () {
                //TODO: logout
                //TODO: Navigate to login screen
              },
            ),
            SizedBox(height: screenSize.height * 0.012,)
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
    );
  }
}
