import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:herodex/presentation/auth/cubit/auth_cubit.dart';
import 'package:herodex/presentation/auth/cubit/auth_state.dart';
import 'package:herodex/data/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUser extends Mock implements User {}

void main() {
  late MockAuthRepository mockRepo;
  late AuthCubit cubit;

  setUp(() {
    mockRepo = MockAuthRepository();
    when(() => mockRepo.authStateChanges).thenAnswer((_) => Stream.value(null));

    cubit = AuthCubit(mockRepo);
  });

  test('initial state is AuthUnauthenticated', () {
    expect(cubit.state, isA<AuthUnauthenticated>());
  });

  test('emits AuthAuthenticated when user is present', () {
    final user = MockUser();

    when(() => mockRepo.authStateChanges).thenAnswer((_) => Stream.value(user));

    final newCubit = AuthCubit(mockRepo);

    expectLater(newCubit.stream, emits(isA<AuthAuthenticated>()));
  });

  test('signOut calls repository', () async {
    when(() => mockRepo.signOut()).thenAnswer((_) async => {});

    await cubit.signOut();

    verify(() => mockRepo.signOut()).called(1);
  });
}
