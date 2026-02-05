import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:herodex/data/repositories/auth_repository.dart';
import 'package:herodex/services/analytics_service.dart';
import 'package:herodex/services/crashlytics_service.dart';

// ----------------------
// Mock classes
// ----------------------
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockAnalyticsService extends Mock implements AnalyticsService {}

class MockCrashlyticsService extends Mock implements CrashlyticsService {}

class MockUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}

class FakeStackTrace extends Fake implements StackTrace {}

void main() {
  late MockFirebaseAuth mockAuth;
  late MockAnalyticsService mockAnalyticsService;
  late MockCrashlyticsService mockCrashlyticsService;
  late AuthRepository repo;

  setUpAll(() {
    registerFallbackValue(FakeStackTrace());
  });

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockAnalyticsService = MockAnalyticsService();
    mockCrashlyticsService = MockCrashlyticsService();

    repo = AuthRepository(
      firebaseAuth: mockAuth,
      analyticsService: mockAnalyticsService,
      crashlyticsService: mockCrashlyticsService,
    );
  });

  // --------------------------------------------------
  // 1. signIn calls FirebaseAuth.signInWithEmailAndPassword
  // --------------------------------------------------
  test('signIn calls FirebaseAuth.signInWithEmailAndPassword', () async {
    final mockUser = MockUser();
    when(() => mockUser.uid).thenReturn('user123');
    
    final mockUserCredential = MockUserCredential();
    when(() => mockUserCredential.user).thenReturn(mockUser);

    when(
      () => mockAuth.signInWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => mockUserCredential);

    // Prevent analytics and crashlytics from throwing
    when(
      () => mockAnalyticsService.logLoginPassword(),
    ).thenAnswer((_) async => {});
    when(
      () => mockCrashlyticsService.setUserId(any()),
    ).thenAnswer((_) async => {});

    await repo.signIn(email: 'test@test.com', password: '123456');

    verify(
      () => mockAuth.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: '123456',
      ),
    ).called(1);
  });

  // --------------------------------------------------
  // 2. signUp calls FirebaseAuth.createUserWithEmailAndPassword
  // --------------------------------------------------
  test('signUp calls FirebaseAuth.createUserWithEmailAndPassword', () async {
    when(
      () => mockAuth.createUserWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => MockUserCredential());

    await repo.signUp(email: 'new@test.com', password: 'abcdef');

    verify(
      () => mockAuth.createUserWithEmailAndPassword(
        email: 'new@test.com',
        password: 'abcdef',
      ),
    ).called(1);
  });

  // --------------------------------------------------
  // 3. signOut calls FirebaseAuth.signOut
  // --------------------------------------------------
  test('signOut calls FirebaseAuth.signOut', () async {
    when(() => mockAuth.signOut()).thenAnswer((_) async => {});

    await repo.signOut();

    verify(() => mockAuth.signOut()).called(1);
  });

  // --------------------------------------------------
  // 4. signIn records error to Crashlytics on failure
  // --------------------------------------------------
  test('signIn records error to Crashlytics on failure', () async {
    final authException = FirebaseAuthException(code: 'wrong-password');
    
    when(
      () => mockAuth.signInWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenThrow(authException);

    when(
      () => mockCrashlyticsService.recordError(any(), any()),
    ).thenAnswer((_) async => {});

    expect(
      () => repo.signIn(email: 'test@test.com', password: 'bad'),
      throwsA(isA<AuthFailure>()),
    );

    verify(
      () => mockCrashlyticsService.recordError(authException, any()),
    ).called(1);
  });
}
