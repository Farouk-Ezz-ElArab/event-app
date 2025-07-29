import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    focusColor: AppColors.whiteColor,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
          color: AppColors.primaryLight
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )
      ),
    ),
    unselectedWidgetColor: AppColors.blackColor,
    disabledColor: AppColors.blackColor,
    cardColor: AppColors.greyColor,
    shadowColor: AppColors.whiteBgColor,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColor: AppColors.primaryLight,
    dividerColor: AppColors.whiteColor,

    scaffoldBackgroundColor: AppColors.whiteBgColor,
    textTheme: TextTheme(
      titleLarge: AppStyles.medium16black,
      displayMedium: AppStyles.bold16Black,
      bodySmall: AppStyles.medium16Grey,
      titleMedium: AppStyles.bold14Black,
      headlineMedium: AppStyles.medium16Primary,
      headlineSmall: AppStyles.medium16White,
      headlineLarge: AppStyles.bold20Black,
      bodyMedium: AppStyles.medium16black,
      labelMedium: AppStyles.medium16White,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: AppColors.transparentColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.whiteColor,
      unselectedItemColor: AppColors.whiteColor,
      showUnselectedLabels: true,
      selectedLabelStyle: AppStyles.bold12White,
      unselectedLabelStyle: AppStyles.bold12White,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryLight,
      shape: StadiumBorder(
        side: BorderSide(color: AppColors.whiteColor, width: 5),
      ),
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    focusColor: AppColors.primaryLight,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
            color: AppColors.primaryLight
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )
        ),
        color: AppColors.primaryDark
    ),
    unselectedWidgetColor: AppColors.whiteColor,
    disabledColor: AppColors.primaryLight,
    cardColor: AppColors.whiteColor,
    shadowColor: AppColors.primaryDark,
    dividerColor: AppColors.primaryDark,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.primaryDark,
    textTheme: TextTheme(
      titleLarge: AppStyles.medium16White,
      displayMedium: AppStyles.bold16Primary,
      bodySmall: AppStyles.medium16White,
      titleMedium: AppStyles.bold14White,
      headlineMedium: AppStyles.medium16White,
      headlineSmall: AppStyles.medium16White,
      headlineLarge: AppStyles.bold20White,
      bodyMedium: AppStyles.medium16White,
      labelMedium: AppStyles.medium16Primary.copyWith(
          color: AppColors.primaryDark
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: AppColors.transparentColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.whiteColor,
      unselectedItemColor: AppColors.whiteColor,
      showUnselectedLabels: true,
      selectedLabelStyle: AppStyles.bold12White,
      unselectedLabelStyle: AppStyles.bold12White,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryDark,
      shape: StadiumBorder(
        side: BorderSide(color: AppColors.whiteColor, width: 5),
      ),
    ),
  );
}
