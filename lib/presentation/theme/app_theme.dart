import 'package:flutter/material.dart';

class AppTheme {
  // Brand colors extracted from your app icon
  static const Color _brandOrange = Color(0xFFE48518); // golden-orange
  static const Color _brandRed = Color(0xFF3A0F0F); // deep burgundy
  static const Color _lightSurface = Color(0xFFF2F2F2); // cool light grey
  static const Color _darkSurface = Color(0xFF121212); // charcoal

  static const Color _navBarColorLight = Color(0xFFE48518);
  static const Color _navBarColorDark = Color(0xFF3A0F0F);

  static const Color _navBarUnselected = Color.fromARGB(195, 200, 200, 200);

  // -----------------------------
  // LIGHT THEME
  // -----------------------------
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // Core color scheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: _brandOrange,
      brightness: Brightness.light,
      primary: _brandOrange,
      secondary: _brandRed,
      surface: _lightSurface,
    ),

    scaffoldBackgroundColor: _lightSurface,

    cardColor: Colors.white, // crisp, clean, no more pink/beige

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: _navBarColorLight,
      selectedItemColor: Colors.white,
      unselectedItemColor: _navBarUnselected,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 1,
    ),

    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black87),
      bodyLarge: TextStyle(color: Colors.black87),
      titleMedium: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
    ),
  );

  // -----------------------------
  // DARK THEME
  // -----------------------------
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: ColorScheme.fromSeed(
      seedColor: _brandOrange,
      brightness: Brightness.dark,
      primary: _brandOrange,
      secondary: _brandRed,
      surface: _darkSurface,
    ),

    scaffoldBackgroundColor: _darkSurface,

    cardColor: const Color(0xFF1E1E1E), // deep charcoal card

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: _navBarColorDark,
      selectedItemColor: Colors.orangeAccent,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 1,
    ),

    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}
