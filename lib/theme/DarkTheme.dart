import 'package:flutter/material.dart';
import 'package:oqy/theme/app_colors.dart';
import 'package:oqy/theme/app_fonts.dart';


class DarkTheme {
  static ThemeData get themeData {
    return ThemeData(
        primaryColor: AppDarkColors.main,
        cardColor: AppDarkColors.mainCard,
        scaffoldBackgroundColor: AppDarkColors.mainBackground,
        appBarTheme: const AppBarTheme(
          foregroundColor: AppFontColors.fontWhite,
          backgroundColor: AppDarkColors.bottomBarBackground,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: AppFontColors.fontWhite,
            fontSize: 40,
            fontWeight: FontWeight.w700,
            fontFamily: AppFonts.mainFont,
          ),
          titleMedium: TextStyle( 
            color: AppFontColors.fontWhite,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: AppFonts.mainFont,
          ),


          bodySmall: TextStyle(
            color: AppFontColors.fontWhite,
            fontSize: 14,
            fontFamily: AppFonts.mainFont,
          ),
          bodyMedium: TextStyle(
            color: AppFontColors.fontWhite,
            fontSize: 16,
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


          displayMedium: TextStyle(
            color: AppFontColors.fontWhite,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.mainFont,
          ),
          displaySmall: TextStyle(
            color: AppFontColors.fontLight,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.mainFont,
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

        focusColor: AppFontColors.fontWhite,
        hintColor: AppFontColors.fontLight,
        secondaryHeaderColor:AppDarkColors.bottomBarBackground,
        unselectedWidgetColor: AppDarkColors.unselectedItem,
        primaryColorDark: AppDarkColors.unselectedItem,

        
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
    );
  }
}