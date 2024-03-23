import 'package:flutter/material.dart';
import 'package:oqy/theme/app_colors.dart';
import 'package:oqy/theme/app_fonts.dart';


class DarkTheme {
  static ThemeData get themeData {
    return ThemeData(
        primaryColor: AppDarkColors.main,
        cardColor: AppDarkColors.mainCard,
        scaffoldBackgroundColor: AppDarkColors.mainBackground,
        appBarTheme:const AppBarTheme(
          color: AppDarkColors.bottomBarBackground,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: AppFontColors.fontWhite,
            fontSize: 40,
            fontWeight: FontWeight.w700,
            fontFamily: AppFonts.mainFont,
          ),
          bodySmall: TextStyle(
            color: AppFontColors.fontLight,
            fontSize: 14,
            fontFamily: AppFonts.mainFont,
          ),
          labelSmall: TextStyle(
            color: AppFontColors.fontLink,
            fontSize: 14,
            fontFamily: AppFonts.mainFont,
          ),
          labelMedium:  TextStyle(
            color: AppFontColors.fontLink,
            fontSize: 16,
            fontFamily: AppFonts.mainFont,
            fontWeight: FontWeight.w700,
          ),
          displayLarge:TextStyle(
            color: AppFontColors.fontWhite,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.mainFont,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color?>(AppDarkColors.main),
          ),
        ),
        focusColor: AppFontColors.fontLight,
        hintColor: AppFontColors.fontLight,
        secondaryHeaderColor:AppDarkColors.bottomBarBackground,
        unselectedWidgetColor: AppDarkColors.unselectedItem,

        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
    );
  }
}