import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herodex/presentation/theme/theme_service.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final ThemeService _themeService;

  ThemeCubit(this._themeService) : super(ThemeMode.system);

  Future<void> loadTheme() async {
    final isDark = await _themeService.isDarkMode();
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> toggleTheme(bool isDark) async {
    await _themeService.setDarkMode(isDark);
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
