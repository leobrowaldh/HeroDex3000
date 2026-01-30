import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:herodex/presentation/auth/widgets/auth_flow.dart';
import 'package:herodex/presentation/auth/cubit/auth_cubit.dart';
import 'package:herodex/presentation/auth/cubit/auth_state.dart';
import 'package:bloc_test/bloc_test.dart';

class MockAuthCubit extends Mock implements AuthCubit {}

void main() {
  testWidgets('shows LoginScreen when unauthenticated', (tester) async {
    final mockCubit = MockAuthCubit();

    // 1. Stub the current state
    when(() => mockCubit.state).thenReturn(AuthUnauthenticated());

    // 2. Stub the stream
    whenListen(mockCubit, Stream<AuthState>.value(AuthUnauthenticated()));

    await tester.pumpWidget(
      BlocProvider<AuthCubit>.value(value: mockCubit, child: const AuthFlow()),
    );

    await tester.pump(); // allow MaterialApp to build

    expect(find.text('Login'), findsWidgets);
  });
}
