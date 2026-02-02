import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herodex/presentation/auth/cubit/auth_cubit.dart';
import 'package:herodex/presentation/auth/cubit/auth_state.dart';
import 'package:herodex/presentation/auth/pages/login_page.dart';
import 'package:herodex/presentation/auth/pages/splash_page.dart';
import 'package:herodex/presentation/routing/router.dart';

class AuthFlow extends StatelessWidget {
  const AuthFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return MaterialApp.router(
            routerConfig: appRouter,
            debugShowCheckedModeBanner: false,
            title: 'HeroDex3000',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
          );
        }

        if (state is AuthUnauthenticated) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: LoginPage(),
          );
        }

        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashPage(),
        );
      },
    );
  }
}
