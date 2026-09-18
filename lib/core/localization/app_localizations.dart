import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('fa', 'IR'),
    Locale('en', 'US'),
  ];

  bool get isPersian => locale.languageCode == 'fa';

  // ═══════════════════════════════════════════
  //  Translation lookup
  // ═══════════════════════════════════════════
  String get appName => isPersian ? 'Busino' : 'Busino';
  String get login => isPersian ? 'ورود' : 'Login';
  String get register => isPersian ? 'ثبت‌نام' : 'Register';
  String get home => isPersian ? 'خانه' : 'Home';
  // ... بقیه‌ی کلیدها می‌تونن اینجا اضافه بشن
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['fa', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}