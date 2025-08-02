import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/utils/app_routes.dart';
import 'package:event_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/app_language_provider.dart';
import '../../providers/app_theme_provider.dart';

class IntroScreenDemo extends StatefulWidget {
  const IntroScreenDemo({super.key});

  @override
  State<IntroScreenDemo> createState() => _IntroScreenDemoState();
}

class _IntroScreenDemoState extends State<IntroScreenDemo> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var screenSize = MediaQuery.of(context).size;
    return IntroductionScreen(
      key: _introKey,
      pages: [
        PageViewModel(
          titleWidget: SizedBox(height: screenSize.height * 0.001),
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.topLogo),
              Image.asset(AppAssets.firstIntro),
              Text(AppLocalizations.of(context)!.find, style: AppStyles.bold20Primary),
              SizedBox(height: screenSize.height * 0.02),
              Text(
                AppLocalizations.of(context)!.dive,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        PageViewModel(
          titleWidget: SizedBox(height: screenSize.height * 0.001),
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.topLogo),
              Image.asset(AppAssets.secondIntro),
              Text(AppLocalizations.of(context)!.effortless, style: AppStyles.bold20Primary),
              SizedBox(height: screenSize.height * 0.02),
              Text(
                AppLocalizations.of(context)!.take,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        PageViewModel(
          titleWidget: SizedBox(height: screenSize.height * 0.001),
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.topLogo),
              Image.asset(AppAssets.thirdIntro),
              Text(AppLocalizations.of(context)!.connect, style: AppStyles.bold20Primary),
              SizedBox(height: screenSize.height * 0.02),
              Text(
                AppLocalizations.of(context)!.make,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
      showBackButton: true,
      back: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: AppColors.primaryLight)
        ),
        child: IconButton(
          onPressed: () {
            _introKey.currentState?.previous();
          },
          icon: Icon(Icons.arrow_back, size: 30,),
          color: AppColors.primaryLight,
        ),
      ),

      showNextButton: true,
      next: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: AppColors.primaryLight)
        ),
        child: IconButton(
          onPressed: () {
            _introKey.currentState?.next();
          },
          icon: Icon(Icons.arrow_forward, size: 30,),
          color: AppColors.primaryLight,
        ),
      ),

      showDoneButton: true,
      done: Text(
        AppLocalizations.of(context)!.done,
        style: AppStyles.bold16Primary,
      ),
      onDone: () {
        Navigator.of(
          context,
        ).pushReplacementNamed(AppRoutes.loginScreenRouteName);
      },
      showSkipButton: true,
      skip: Text(
        AppLocalizations.of(context)!.skip,
        style: AppStyles.bold16Primary,
      ),
      onSkip: () {
        Navigator.of(
          context,
        ).pushReplacementNamed(AppRoutes.loginScreenRouteName);
      },
      dotsContainerDecorator: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      dotsDecorator: DotsDecorator(
        activeSize: Size(24, 10),
        activeColor: AppColors.primaryLight,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: AppColors.blackColor,
      ),
    );
  }
}
