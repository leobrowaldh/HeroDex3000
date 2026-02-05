import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:herodex/presentation/onboarding/services/onboarding_service.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics;
  final OnboardingService _onboardingService;

  AnalyticsService({
    required FirebaseAnalytics analytics,
    required OnboardingService onboardingService,
  })  : _analytics = analytics,
        _onboardingService = onboardingService;

  Future<bool> _isAnalyticsEnabled() async {
    return await _onboardingService.getAnalytics();
  }

  Future<void> logLoginPassword() async {
    if (!await _isAnalyticsEnabled()) return;
    await _analytics.logLogin(loginMethod: 'password');
  }

  Future<void> logEvent(String name, Map<String, Object> params) async {
    if (!await _isAnalyticsEnabled()) return;
    await _analytics.logEvent(name: name, parameters: params);
  }

  Future<void> logHeroViewed(String heroId, String heroName) async {
    if (!await _isAnalyticsEnabled()) return;
    await _analytics.logEvent(
      name: 'hero_viewed',
      parameters: {
        'hero_id': heroId,
        'hero_name': heroName,
      },
    );
  }
}
