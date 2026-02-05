import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:herodex/presentation/theme/theme_service.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemeService _themeService;

  ThemeCubit(this._themeService) : super(const ThemeState());

  Future<void> loadTheme() async {
    final isDark = await _themeService.isDarkMode();
    final isHighContrast = await _themeService.isHighContrast();
    emit(ThemeState(
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      isHighContrast: isHighContrast,
    ));
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final isDark = mode == ThemeMode.dark;
    await _themeService.setDarkMode(isDark);
    emit(state.copyWith(themeMode: mode));
  }

  Future<void> toggleTheme(bool isDark) async {
    await setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> toggleHighContrast(bool isHighContrast) async {
    await _themeService.setHighContrast(isHighContrast);
    emit(state.copyWith(isHighContrast: isHighContrast));
  }
}
