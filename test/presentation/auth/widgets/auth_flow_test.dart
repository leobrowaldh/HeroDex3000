import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:herodex/presentation/auth/widgets/auth_flow.dart';
import 'package:herodex/presentation/auth/cubit/auth_cubit.dart';
import 'package:herodex/presentation/auth/cubit/auth_state.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:herodex/data/repositories/auth_repository.dart';

class MockAuthCubit extends Mock implements AuthCubit {}

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  testWidgets('shows LoginScreen when unauthenticated', (tester) async {
    final mockCubit = MockAuthCubit();

    // 1. Stub the current state
    when(() => mockCubit.state).thenReturn(AuthUnauthenticated());

    // 2. Stub the stream
    whenListen(mockCubit, Stream<AuthState>.value(AuthUnauthenticated()));

    final mockAuthRepo = MockAuthRepository();

    await tester.pumpWidget(
      RepositoryProvider<AuthRepository>.value(
        value: mockAuthRepo,
        child: BlocProvider<AuthCubit>.value(
          value: mockCubit,
          child: const AuthFlow(),
        ),
      ),
    );

    await tester.pump(); // allow MaterialApp to build

    expect(find.text('HeroDex 3000 Login'), findsWidgets);
  });
}
