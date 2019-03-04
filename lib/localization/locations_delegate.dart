import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_news/localization/my_locations.dart';


class MyLocationDelegate extends LocalizationsDelegate<MyLocation> {
  const MyLocationDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'zh', 'pt'].contains(locale.languageCode);

  @override
  Future<MyLocation> load(Locale locale) async {
    MyLocation localizations = new MyLocation(locale);
    await localizations.load();

    print("Load ${locale.languageCode}");

    return localizations;
  }

  @override
  bool shouldReload(MyLocationDelegate old) => false;

  Locale resolution(Locale locale, Iterable<Locale> supportedLocales) {
    for (Locale supportedLocale in supportedLocales) {
      if (locale != null) {
        if (supportedLocale.languageCode == locale.languageCode ||
            supportedLocale.countryCode == locale.countryCode) {
          return supportedLocale;
        }
      }
    }
    return supportedLocales.first;
  }

  static List<Locale> supportedLocales() {
    return [
      const Locale('en', 'US'),
      const Locale('zh', 'CH'),
      const Locale('pt', 'BR'),
    ];
  }
}