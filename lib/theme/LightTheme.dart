
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oqy/theme/app_colors.dart';
import 'package:oqy/theme/app_fonts.dart';

class LightTheme {
  static ThemeData get themeData {
    return  ThemeData(
        primaryColor: AppLightColors.main,
        cardColor: AppLightColors.mainCard,
        scaffoldBackgroundColor:  AppLightColors.mainBackground,
        appBarTheme:  const AppBarTheme(
          backgroundColor: AppLightColors.bottomBarBackground, 
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: AppFontColors.mainFont,
            fontSize: 40,
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.mainFont,
          ),
          titleMedium: TextStyle( 
            color: AppFontColors.mainFont,
            fontSize: 26,
            fontWeight: FontWeight.w700,
            fontFamily: AppFonts.mainFont,
          ),
          bodySmall: TextStyle(
            color: AppFontColors.fontMid,
            fontSize: 14,
            fontFamily: AppFonts.mainFont,
          ),
          labelMedium:  TextStyle(
            color: AppFontColors.fontLink,
            fontSize: 16,
            fontFamily: AppFonts.mainFont,
            fontWeight: FontWeight.w700,
          ),
          labelSmall: TextStyle(
            color: AppFontColors.fontLink,
            fontSize: 14,
            fontFamily: AppFonts.mainFont,
          ),
          displayLarge:TextStyle(
            color: AppFontColors.mainFont,
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

        focusColor: AppFontColors.mainFont,
        hintColor: AppFontColors.fontMid,
        unselectedWidgetColor: AppLightColors.unselectedItem,
        secondaryHeaderColor: AppLightColors.bottomBarBackground,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
    );
  }
}

