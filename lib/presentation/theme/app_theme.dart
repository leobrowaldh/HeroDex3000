import 'package:flutter/material.dart';

class AppTheme {
  static const Color _seedColor = Color.fromARGB(255, 228, 133, 24);
  static const Color _navBarColor = Color.fromARGB(255, 207, 93, 16);
  static const Color _navBarUnselected = Color.fromARGB(195, 200, 200, 200);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: _navBarColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: _navBarUnselected,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 60, 30, 0), // Darker orange/brown for dark mode
      selectedItemColor: Colors.orangeAccent,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
