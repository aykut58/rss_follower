// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ThemeManager {
  static ThemeManager? _instance;
  static ThemeManager get instance {
    _instance ??= ThemeManager._init();
    return _instance!;
  }

  ThemeManager._init();

  final light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.indigo,
  
    bottomNavigationBarTheme: BottomNavigationBarThemeData
    (
      backgroundColor: Colors.indigo
    ),
    scaffoldBackgroundColor: Color(0xfff1f1f1), bottomAppBarTheme: BottomAppBarTheme(color: Colors.indigo),
  );

  final dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.indigo,
   
  );
}
