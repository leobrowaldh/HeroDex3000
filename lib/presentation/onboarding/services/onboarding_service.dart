import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  static const _keyOnboardingDone = 'onboarding_done';
  static const _keyAnalytics = 'pref_analytics';
  static const _keyCrashlytics = 'pref_crashlytics';
  static const _keyLocation = 'pref_location';

  Future<void> setOnboardingDone(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOnboardingDone, value);
  }

  Future<bool> isOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyOnboardingDone) ?? false;
  }

  Future<void> savePreferences({
    required bool analytics,
    required bool crashlytics,
    required bool location,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyAnalytics, analytics);
    await prefs.setBool(_keyCrashlytics, crashlytics);
    await prefs.setBool(_keyLocation, location);
  }

  Future<bool> getAnalytics() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyAnalytics) ?? false;
  }

  Future<bool> getCrashlytics() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyCrashlytics) ?? false;
  }

  Future<bool> getLocation() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyLocation) ?? false;
  }

  static const _keyAttStatus = 'pref_att_status';

  Future<void> setAttStatus(String status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAttStatus, status);
  }

  Future<String?> getAttStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAttStatus);
  }
}
