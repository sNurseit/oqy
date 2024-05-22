import 'package:flutter/material.dart';
import 'package:oqy/generated/l10n.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('en');
  Locale get locale => _locale;


  void setLocale(Locale locale) {
    if (!S.delegate.supportedLocales.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = Locale('en');
    notifyListeners();
  }


}
