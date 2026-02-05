import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:herodex/presentation/onboarding/services/onboarding_service.dart';

class CrashlyticsService {
  final FirebaseCrashlytics _crashlytics;
  final OnboardingService _onboardingService;

  CrashlyticsService({
    required FirebaseCrashlytics crashlytics,
    required OnboardingService onboardingService,
  })  : _crashlytics = crashlytics,
        _onboardingService = onboardingService;

  Future<bool> _isCrashlyticsEnabled() async {
    return await _onboardingService.getCrashlytics();
  }

  Future<void> recordError(dynamic error, StackTrace stack) async {
    if (!await _isCrashlyticsEnabled()) return;
    await _crashlytics.recordError(error, stack);
  }

  Future<void> log(String message) async {
    if (!await _isCrashlyticsEnabled()) return;
    _crashlytics.log(message);
  }

  Future<void> setUserId(String uid) async {
    if (!await _isCrashlyticsEnabled()) return;
    await _crashlytics.setUserIdentifier(uid);
  }

  Future<void> logNavigation(String routeName) async {
    if (!await _isCrashlyticsEnabled()) return;
    _crashlytics.log('Navigation: $routeName');
  }
}
