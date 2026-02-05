import 'package:flutter/foundation.dart';
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
    if (kIsWeb) return false;
    return await _onboardingService.getCrashlytics();
  }

  Future<void> recordError(dynamic error, StackTrace stack) async {
    if (kIsWeb) return;
    if (!await _isCrashlyticsEnabled()) return;
    await _crashlytics.recordError(error, stack);
  }

  Future<void> log(String message) async {
    if (kIsWeb) return;
    if (!await _isCrashlyticsEnabled()) return;
    _crashlytics.log(message);
  }

  Future<void> setUserId(String uid) async {
    if (kIsWeb) return;
    if (!await _isCrashlyticsEnabled()) return;
    await _crashlytics.setUserIdentifier(uid);
  }

  Future<void> logNavigation(String routeName) async {
    if (kIsWeb) return;
    if (!await _isCrashlyticsEnabled()) return;
    _crashlytics.log('Navigation: $routeName');
  }
}
