import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herodex/presentation/onboarding/services/onboarding_service.dart';
import 'package:herodex/presentation/settings/cubit/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final OnboardingService _onboardingService;

  SettingsCubit(this._onboardingService) : super(const SettingsState());

  Future<void> loadSettings() async {
    emit(state.copyWith(isLoading: true));
    final analytics = await _onboardingService.getAnalytics();
    final crashlytics = await _onboardingService.getCrashlytics();
    final location = await _onboardingService.getLocation();
    final attStatus = await _onboardingService.getAttStatus();

    emit(
      state.copyWith(
        analytics: analytics,
        crashlytics: crashlytics,
        location: location,
        attStatus: attStatus,
        isLoading: false,
      ),
    );
  }

  Future<void> toggleAnalytics(bool value) async {
    await _onboardingService.savePreferences(
      analytics: value,
      crashlytics: state.crashlytics,
      location: state.location,
    );
    emit(state.copyWith(analytics: value));
  }

  Future<void> toggleCrashlytics(bool value) async {
    await _onboardingService.savePreferences(
      analytics: state.analytics,
      crashlytics: value,
      location: state.location,
    );
    emit(state.copyWith(crashlytics: value));
  }

  Future<void> toggleLocation(bool value) async {
    await _onboardingService.savePreferences(
      analytics: state.analytics,
      crashlytics: state.crashlytics,
      location: value,
    );
    emit(state.copyWith(location: value));
  }
}

