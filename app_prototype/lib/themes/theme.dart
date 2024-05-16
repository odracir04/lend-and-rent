import 'package:flutter/material.dart';

class Themes {
  static getTheme(bool darkMode) {
    return ThemeData(
      scaffoldBackgroundColor: darkMode ? Colors.black12 : Colors.white70,
      primaryColor: darkMode ? Colors.black : Colors.grey.shade400,
      brightness: darkMode ? Brightness.dark : Brightness.light,
      cardColor: darkMode ? Colors.grey.shade800 : Colors.grey.shade200,
      searchBarTheme: SearchBarThemeData(
        backgroundColor: darkMode ?
        MaterialStatePropertyAll(Colors.grey.shade800)
            : MaterialStatePropertyAll(Colors.grey.shade400),
        hintStyle: MaterialStateProperty.all(
            const TextStyle(fontWeight: FontWeight.w700, color: Colors.black26))
      ),
      buttonTheme: ButtonThemeData(
        colorScheme: darkMode ? const ColorScheme.dark() : const ColorScheme.light()
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              return darkMode ? Colors.white : Colors.grey.shade900;
            })
        )
      )
    );
  }
}