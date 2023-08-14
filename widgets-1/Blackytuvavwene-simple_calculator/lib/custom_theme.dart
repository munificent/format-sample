import 'package:flutter/material.dart';
import 'package:simple_calculator/config.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = true;
  ThemeMode currentTheme() => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  CustomTheme() {
    if (themeBox!.containsKey('currentTheme')) {
      _isDarkTheme = themeBox!.get('currentTheme') as bool;
    } else {
      themeBox!.put('currentTheme', _isDarkTheme);
    }
  }

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    themeBox!.put('currentTheme', _isDarkTheme);
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.white,
      backgroundColor: Colors.black12,
      accentColor: Colors.black12,
      textTheme: const TextTheme(
        headline1: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 75,
        ),
        button: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.w900,
        ),
        headline2: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 55,
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          fixedSize: const Size(70, 70),
          minimumSize: const Size(65, 65),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.black12,
          elevation: 15,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      iconTheme: const IconThemeData(color: Colors.white),
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      accentColor: Colors.grey,
      textTheme: const TextTheme(
        headline1: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 75,
        ),
        button: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w900,
        ),
        headline2: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 55,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          fixedSize: const Size(70, 70),
          minimumSize: const Size(65, 65),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.black,
          elevation: 15,
        ),
      ),
    );
  }
}
