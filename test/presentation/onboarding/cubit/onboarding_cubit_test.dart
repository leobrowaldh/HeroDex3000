import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:herodex/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:herodex/presentation/onboarding/services/onboarding_service.dart';

class MockOnboardingService extends Mock implements OnboardingService {}

void main() {
  late MockOnboardingService mockService;
  late OnboardingCubit cubit;

  setUp(() {
    mockService = MockOnboardingService();
    cubit = OnboardingCubit(mockService);
  });

  test('initial state is OnboardingInitial', () {
    expect(cubit.state, isA<OnboardingInitial>());
  });

  test('setAttStatus calls service', () async {
    when(() => mockService.setAttStatus(any())).thenAnswer((_) async => {});

    await cubit.setAttStatus('authorized');

    verify(() => mockService.setAttStatus('authorized')).called(1);
  });

  test('completeOnboarding saves all preferences', () async {
    when(() => mockService.savePreferences(
          analytics: any(named: 'analytics'),
          crashlytics: any(named: 'crashlytics'),
          location: any(named: 'location'),
        )).thenAnswer((_) async => {});
    when(() => mockService.setOnboardingDone(any())).thenAnswer((_) async => {});

    await cubit.completeOnboarding();

    verify(() => mockService.savePreferences(
          analytics: false,
          crashlytics: false,
          location: false,
        )).called(1);
    verify(() => mockService.setOnboardingDone(true)).called(1);
  });
}
