

import 'package:flutter/material.dart';

abstract class AppLightColors{
  static const mainBackground = Color.fromRGBO(242, 242, 242, 1);
  static const unselectedItem = Color.fromRGBO(51, 51, 51, 0.8);
  static const main= Color.fromRGBO(48, 123, 166, 1);
  static const bottomBarBackground= Color.fromRGBO(255,255,255,0.8);
}

abstract class AppFontColors{
  static const mainFont= Color.fromRGBO(15, 15, 15, 1.0);
  static const fontMid = Color.fromRGBO(15, 15, 15, 0.6);
  static const fontLight = Color.fromRGBO(255, 255, 255, 0.7);
  static const fontLink = Color.fromRGBO(29,161,242,1);
  static const fontWhite = Color.fromRGBO(255, 255, 255, 1.0);
}

abstract class AppDarkColors{
  static const mainBackground = Color.fromRGBO(26, 26, 26, 1);
  static const unselectedItem = Color.fromRGBO(242, 242, 242, 1);
  static const mainCard= Color.fromRGBO(51, 51, 51, 1);
  static const main= Color.fromRGBO(48, 123, 166, 1);
  static const bottomBarBackground= Color.fromRGBO(51, 51, 51, 0.8);
}