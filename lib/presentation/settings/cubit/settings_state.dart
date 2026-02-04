import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final bool analytics;
  final bool crashlytics;
  final bool location;
  final bool isLoading;

  const SettingsState({
    this.analytics = false,
    this.crashlytics = false,
    this.location = false,
    this.isLoading = true,
  });

  SettingsState copyWith({
    bool? analytics,
    bool? crashlytics,
    bool? location,
    bool? isLoading,
  }) {
    return SettingsState(
      analytics: analytics ?? this.analytics,
      crashlytics: crashlytics ?? this.crashlytics,
      location: location ?? this.location,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [analytics, crashlytics, location, isLoading];
}
