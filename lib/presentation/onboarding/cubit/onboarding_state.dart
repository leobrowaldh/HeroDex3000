part of 'onboarding_cubit.dart';

abstract class OnboardingState {
  final bool analytics;
  final bool crashlytics;
  final bool location;

  const OnboardingState({
    required this.analytics,
    required this.crashlytics,
    required this.location,
  });
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial({
    super.analytics = false,
    super.crashlytics = false,
    super.location = false,
  });
}

class OnboardingInProgress extends OnboardingState {
  const OnboardingInProgress({
    required super.analytics,
    required super.crashlytics,
    required super.location,
  });
}

class OnboardingCompleted extends OnboardingState {
  const OnboardingCompleted({
    required super.analytics,
    required super.crashlytics,
    required super.location,
  });
}
