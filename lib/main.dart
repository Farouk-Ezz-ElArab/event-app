// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:event_app/core/shared_preference.dart';
// import 'package:event_app/providers/app_theme_provider.dart';
// import 'package:event_app/providers/event_list_provider.dart';
// import 'package:event_app/ui/authentication/login/login_screen.dart';
// import 'package:event_app/ui/authentication/register/register_screen.dart';
// import 'package:event_app/ui/home/add_event/add_event.dart';
// import 'package:event_app/ui/home/event_details/edit_event_screen.dart';
// import 'package:event_app/ui/home/home_screen.dart';
// import 'package:event_app/ui/intro_screens/intro_screen.dart';
// import 'package:event_app/ui/intro_screens/pre_intro_screen.dart';
// import 'package:event_app/utils/app_consts.dart';
// import 'package:event_app/utils/app_routes.dart';
// import 'package:event_app/utils/app_theme.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'firebase_options.dart';
// import 'l10n/app_localizations.dart';
// import 'providers/app_language_provider.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await FirebaseFirestore.instance.disableNetwork();
//   SharedPreference prefs = SharedPreference();
//   String locale = await prefs.getData(AppConsts.languageKey) ?? 'en';
//   String theme =
//       await prefs.getData(AppConsts.themeKey) ?? AppConsts.lightThemeString;
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (context) => AppLanguageProvider(appLanguage: locale),
//         ),
//         ChangeNotifierProvider(
//           create: (context) => AppThemeProvider(
//             appTheme: theme == AppConsts.darkThemeString
//                 ? ThemeMode.dark
//                 : ThemeMode.light,
//           ),
//         ),
//         ChangeNotifierProvider(create: (context) => EventsListProvider()),
//       ],
//       child: MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     var themeProvider = Provider.of<AppThemeProvider>(context);
//     var languageProvider = Provider.of<AppLanguageProvider>(context);
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: AppRoutes.homeScreenRouteName,
//       routes: {
//         AppRoutes.homeScreenRouteName: (context) => HomeScreen(),
//         AppRoutes.editEventScreenRouteName: (context) => EditEventScreen(event: ,),
//         AppRoutes.preIntroScreenRouteName: (context) => PreIntroScreen(),
//         AppRoutes.introScreenRouteName: (context) => IntroScreenDemo(),
//         AppRoutes.loginScreenRouteName: (context) => LoginScreen(),
//         AppRoutes.registerScreenRouteName: (context) => RegisterScreen(),
//         AppRoutes.addEventScreenRouteName: (context) => AddEvent(),
//       },
//       locale: Locale(languageProvider.appLanguage),
//       themeMode: themeProvider.appTheme,
//       localizationsDelegates: AppLocalizations.localizationsDelegates,
//       supportedLocales: AppLocalizations.supportedLocales,
//       theme: AppTheme.lightTheme,
//       darkTheme: AppTheme.darkTheme,
//     );
//   }
// }

// Alternative approach using route arguments
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/shared_preference.dart';
import 'package:event_app/providers/app_theme_provider.dart';
import 'package:event_app/providers/event_list_provider.dart';
import 'package:event_app/ui/authentication/login/login_screen.dart';
import 'package:event_app/ui/authentication/register/register_screen.dart';
import 'package:event_app/ui/home/add_event/add_event.dart';
import 'package:event_app/ui/home/event_details/edit_event_screen.dart';
import 'package:event_app/ui/home/event_details/event_details_screen.dart';
import 'package:event_app/ui/home/home_screen.dart';
import 'package:event_app/ui/intro_screens/intro_screen.dart';
import 'package:event_app/ui/intro_screens/pre_intro_screen.dart';
import 'package:event_app/utils/app_consts.dart';
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
  SharedPreference prefs = SharedPreference();
  String locale = await prefs.getData(AppConsts.languageKey) ?? 'en';
  String theme =
      await prefs.getData(AppConsts.themeKey) ?? AppConsts.lightThemeString;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppLanguageProvider(appLanguage: locale),
        ),
        ChangeNotifierProvider(
          create: (context) => AppThemeProvider(
            appTheme: theme == AppConsts.darkThemeString
                ? ThemeMode.dark
                : ThemeMode.light,
          ),
        ),
        ChangeNotifierProvider(create: (context) => EventsListProvider()),
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
      initialRoute: AppRoutes.preIntroScreenRouteName,
      routes: {
        AppRoutes.preIntroScreenRouteName: (context) => PreIntroScreen(),
        AppRoutes.homeScreenRouteName: (context) => HomeScreen(),
        AppRoutes.eventDetailsScreenRouteName: (context) =>
            EventDetailsScreen(),
        AppRoutes.editEventScreenRouteName: (context) => EditEventScreen(),
        AppRoutes.introScreenRouteName: (context) => IntroScreenDemo(),
        AppRoutes.loginScreenRouteName: (context) => LoginScreen(),
        AppRoutes.registerScreenRouteName: (context) => RegisterScreen(),
        AppRoutes.addEventScreenRouteName: (context) => AddEvent(),
      },
      locale: Locale(languageProvider.appLanguage),
      themeMode: themeProvider.appTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
