import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:herodex/presentation/settings/cubit/settings_cubit.dart';
import 'package:herodex/presentation/onboarding/services/onboarding_service.dart';

class MockOnboardingService extends Mock implements OnboardingService {}

void main() {
  late MockOnboardingService mockService;
  late SettingsCubit cubit;

  setUp(() {
    mockService = MockOnboardingService();
    cubit = SettingsCubit(mockService);
  });

  test('initial state has default values and isLoading true', () {
    expect(cubit.state.isLoading, true);
    expect(cubit.state.analytics, false);
    expect(cubit.state.attStatus, isNull);
  });

  test('loadSettings updates state with service values including attStatus', () async {
    when(() => mockService.getAnalytics()).thenAnswer((_) async => true);
    when(() => mockService.getCrashlytics()).thenAnswer((_) async => false);
    when(() => mockService.getLocation()).thenAnswer((_) async => true);
    when(() => mockService.getAttStatus()).thenAnswer((_) async => 'denied');

    await cubit.loadSettings();

    expect(cubit.state.isLoading, false);
    expect(cubit.state.analytics, true);
    expect(cubit.state.crashlytics, false);
    expect(cubit.state.location, true);
    expect(cubit.state.attStatus, 'denied');
  });

  test('toggleAnalytics call service and updates state', () async {
    // Initial load to set state
    when(() => mockService.getAnalytics()).thenAnswer((_) async => false);
    when(() => mockService.getCrashlytics()).thenAnswer((_) async => false);
    when(() => mockService.getLocation()).thenAnswer((_) async => false);
    when(() => mockService.getAttStatus()).thenAnswer((_) async => null);
    await cubit.loadSettings();

    when(() => mockService.savePreferences(
          analytics: true,
          crashlytics: false,
          location: false,
        )).thenAnswer((_) async => {});

    await cubit.toggleAnalytics(true);

    expect(cubit.state.analytics, true);
    verify(() => mockService.savePreferences(
          analytics: true,
          crashlytics: false,
          location: false,
        )).called(1);
  });
}
