import 'package:flutter/material.dart';
import 'package:oqy/domain/provider/locale_provider.dart';
import 'package:oqy/generated/l10n.dart';
import 'package:provider/provider.dart';

class LanguagePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return DropdownButton<Locale>(
      value: localeProvider.locale,
      icon: const Icon(Icons.language),
      onChanged: (Locale? newLocale) {
        if (newLocale != null) {
          localeProvider.setLocale(newLocale);
        }
      },
      items: S.delegate.supportedLocales.map<DropdownMenuItem<Locale>>((Locale locale) {
        final flag = _getFlag(locale.languageCode);
        return DropdownMenuItem<Locale>(
          value: locale,
          child: Text(flag),
        );
      }).toList(),
    );
  }

  String _getFlag(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'ru':
        return 'Русский';
      case 'kk':
        return 'Қазақша';
      default:
        return 'Unknown';
    }
  }
}