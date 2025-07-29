import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/providers/app_theme_provider.dart';
import 'package:event_app/ui/authentication/login/login_screen.dart';
import 'package:event_app/ui/authentication/register/register_screen.dart';
import 'package:event_app/ui/home/add_event/add_event.dart';
import 'package:event_app/ui/home/home_screen.dart';
import 'package:event_app/ui/intro_screens/intro_screen.dart';
import 'package:event_app/ui/intro_screens/pre_intro_screen.dart';
import 'package:event_app/utils/app_routes.dart';
import 'package:event_app/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'providers/app_language_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseFirestore.instance.disableNetwork();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (context) => AppThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeScreenRouteName,
      routes: {
        AppRoutes.homeScreenRouteName: (context) => HomeScreen(),
        AppRoutes.loginScreenRouteName: (context) => LoginScreen(),
        AppRoutes.registerScreenRouteName: (context) => RegisterScreen(),
        AppRoutes.preIntroScreenRouteName: (context) => PreIntroScreen(),
        AppRoutes.introScreenRouteName: (context) => IntroScreenDemo(),
        AppRoutes.addEventScreenRouteName: (context) => AddEvent(),
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
