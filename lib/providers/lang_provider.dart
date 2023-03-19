import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

class LangProvider with ChangeNotifier 
{
  String phoneLanguage = ui.window.locale.languageCode; /// telefonun sistem dilini alıyor.
  Locale _locale =Locale("tr");

  Locale get getLocale => _locale;

  void setLocale(Locale newLocale,BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', newLocale.languageCode);
    // ignore: deprecated_member_use, use_build_context_synchronously
    context.locale = newLocale;
    _locale = newLocale;
    notifyListeners();
  }

  Future<void> loadLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString('languageCode') ?? phoneLanguage;
  _locale = Locale(languageCode);
  notifyListeners();
  }
}