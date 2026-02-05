import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const _keyDarkMode = 'pref_dark_mode';

  Future<void> setDarkMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyDarkMode, isDark);
  }

  Future<bool> isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyDarkMode) ?? false;
  }

  static const _keyHighContrast = 'pref_high_contrast';

  Future<void> setHighContrast(bool isHighContrast) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyHighContrast, isHighContrast);
  }

  Future<bool> isHighContrast() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyHighContrast) ?? false;
  }
}
