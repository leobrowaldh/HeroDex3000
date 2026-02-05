part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;
  final bool isHighContrast;

  const ThemeState({
    this.themeMode = ThemeMode.system,
    this.isHighContrast = false,
  });

  ThemeState copyWith({
    ThemeMode? themeMode,
    bool? isHighContrast,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      isHighContrast: isHighContrast ?? this.isHighContrast,
    );
  }

  @override
  List<Object> get props => [themeMode, isHighContrast];
}
