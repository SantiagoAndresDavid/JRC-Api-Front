
import 'package:flutter/material.dart';

ColorTheme currentTheme = ColorTheme();

class ColorTheme with ChangeNotifier{
  static bool _isDarkTheme = true;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get whiteTheme {
    return ThemeData(
      primaryColor: Colors.lightBlue,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        headline1: TextStyle(color: Colors.black),
        headline2: TextStyle(color: Colors.white),
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.white),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Color.fromARGB(51, 255, 189, 244),
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      textTheme: const TextTheme(
        headline1: TextStyle(color: Colors.white),
        headline2: TextStyle(color: Colors.black),
        bodyText1: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.black),
      ),
    );
  }
}