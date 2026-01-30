import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:herodex/data/repositories/auth_repository.dart';

// ----------------------
// Mock classes
// ----------------------
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late MockFirebaseAuth mockAuth;
  late MockFirebaseAnalytics mockAnalytics;
  late AuthRepository repo;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockAnalytics = MockFirebaseAnalytics();

    repo = AuthRepository(firebaseAuth: mockAuth, analytics: mockAnalytics);
  });

  // --------------------------------------------------
  // 1. signIn calls FirebaseAuth.signInWithEmailAndPassword
  // --------------------------------------------------
  test('signIn calls FirebaseAuth.signInWithEmailAndPassword', () async {
    when(
      () => mockAuth.signInWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => MockUserCredential());

    // Prevent analytics from throwing
    when(
      () => mockAnalytics.logLogin(loginMethod: any(named: 'loginMethod')),
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
}
