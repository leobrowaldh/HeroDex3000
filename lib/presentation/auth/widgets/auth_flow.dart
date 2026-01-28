import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herodex/presentation/auth/cubit/auth_cubit.dart';
import 'package:herodex/presentation/auth/cubit/auth_state.dart';
import 'package:herodex/presentation/auth/widgets/login_screen.dart';
import 'package:herodex/presentation/auth/widgets/splash_screen.dart';
import 'package:herodex/presentation/pages/home.dart';

class AuthFlow extends StatelessWidget {
  const AuthFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return const Home(title: 'HeroDex3000');
        }
        if (state is AuthUnauthenticated) {
          return const LoginScreen();
        }
        return const SplashScreen();
      },
    );
  }
}
