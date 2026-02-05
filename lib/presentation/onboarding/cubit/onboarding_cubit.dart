import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herodex/presentation/onboarding/services/onboarding_service.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingService _service;

  OnboardingCubit(this._service) : super(const OnboardingInitial());

  void setAnalytics(bool value) {
    emit(OnboardingInProgress(
      analytics: value,
      crashlytics: state.crashlytics,
      location: state.location,
    ));
  }

  void setCrashlytics(bool value) {
    emit(OnboardingInProgress(
      analytics: state.analytics,
      crashlytics: value,
      location: state.location,
    ));
  }

  void setLocation(bool value) {
    emit(OnboardingInProgress(
      analytics: state.analytics,
      crashlytics: state.crashlytics,
      location: value,
    ));
  }

  Future<void> setAttStatus(String status) async {
    await _service.setAttStatus(status);
  }

  Future<void> completeOnboarding() async {
    await _service.savePreferences(
      analytics: state.analytics,
      crashlytics: state.crashlytics,
      location: state.location,
    );
    await _service.setOnboardingDone(true);
    
    emit(OnboardingCompleted(
      analytics: state.analytics,
      crashlytics: state.crashlytics,
      location: state.location,
    ));
  }
}
