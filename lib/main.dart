import 'package:event_app/providers/app_theme_provider.dart';
import 'package:event_app/ui/home/home_screen.dart';
import 'package:event_app/ui/intro_screens/intro_screen.dart';
import 'package:event_app/ui/intro_screens/pre_intro_screen.dart';
import 'package:event_app/utils/app_routes.dart';
import 'package:event_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_language_provider.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AppLanguageProvider(),),
    ChangeNotifierProvider(create: (context) => AppThemeProvider(),)
  ],
  child: MyApp()));
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.preIntroScreenRouteName,
      routes: {
        AppRoutes.preIntroScreenRouteName: (context)=> PreIntroScreen(),
        AppRoutes.introScreenRouteName: (context)=> IntroScreenDemo(),
        AppRoutes.homeScreenRouteName: (context)=>HomeScreen(),
      },
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
    );
  }
}