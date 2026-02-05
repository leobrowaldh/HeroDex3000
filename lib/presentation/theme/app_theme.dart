import 'package:flutter/material.dart';

class AppTheme {
  // Brand colors
  static const Color _brandOrange = Color(0xFFE48518);
  static const Color _brandRed = Color(0xFF3A0F0F);

  // Surfaces
  static const Color _lightSurface = Color(0xFFF7F7F7);
  static const Color _darkSurface = Color(0xFF121212);

  // -----------------------------
  // LIGHT THEME
  // -----------------------------
  static ThemeData getLightTheme({bool isHighContrast = false}) {
    const Color _lightCard = Colors.white;
    const Color _lightIconUnselected = Color(0xFF7A7A7A);

    final colorScheme = ColorScheme.fromSeed(
      seedColor: _brandOrange,
      brightness: Brightness.light,
      primary: _brandOrange,
      secondary: _brandRed,
      surface: isHighContrast ? Colors.white : _lightSurface,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: isHighContrast ? Colors.white : _lightSurface,

      cardColor: _lightCard,
      cardTheme: CardThemeData(
        color: _lightCard,
        shape: isHighContrast
            ? RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(12),
              )
            : null,
        elevation: isHighContrast ? 0 : 1,
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: _brandOrange,
        unselectedItemColor: _lightIconUnselected,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: isHighContrast
            ? const TextStyle(fontWeight: FontWeight.w900, fontSize: 14)
            : null,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),

      textTheme: TextTheme(
        bodyMedium: TextStyle(
          color: Colors.black87,
          fontWeight: isHighContrast ? FontWeight.bold : null,
        ),
        bodyLarge: TextStyle(
          color: Colors.black87,
          fontWeight: isHighContrast ? FontWeight.bold : null,
        ),
        titleMedium: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // -----------------------------
  // DARK THEME
  // -----------------------------
  static ThemeData getDarkTheme({bool isHighContrast = false}) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _brandOrange,
      brightness: Brightness.dark,
      primary: _brandOrange,
      secondary: _brandRed,
      surface: isHighContrast ? Colors.black : _darkSurface,
      onSurface: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: isHighContrast ? Colors.black : _darkSurface,

      cardColor: const Color(0xFF1E1E1E),
      cardTheme: CardThemeData(
        color: isHighContrast ? Colors.black : const Color(0xFF1E1E1E),
        shape: isHighContrast
            ? RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(12),
              )
            : null,
        elevation: isHighContrast ? 0 : null,
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: _brandRed,
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: isHighContrast
            ? const TextStyle(fontWeight: FontWeight.w900, fontSize: 14)
            : null,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: isHighContrast
            ? Colors.black
            : const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        elevation: 1,
      ),

      textTheme: TextTheme(
        bodyMedium: TextStyle(
          color: Colors.white,
          fontWeight: isHighContrast ? FontWeight.bold : null,
        ),
        bodyLarge: TextStyle(
          color: Colors.white,
          fontWeight: isHighContrast ? FontWeight.bold : null,
        ),
        titleMedium: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
