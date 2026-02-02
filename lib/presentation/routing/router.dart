import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:herodex/injection.dart';
import 'package:herodex/presentation/auth/pages/login_page.dart';
import 'package:herodex/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:herodex/presentation/onboarding/pages/onboarding_permissions_page.dart';
import 'package:herodex/presentation/onboarding/services/onboarding_service.dart';
import 'package:herodex/presentation/pages/detail_screen.dart';
import 'package:herodex/presentation/pages/home.dart';
import 'package:herodex/presentation/onboarding/pages/onboarding_intro_page.dart';
import 'package:herodex/presentation/onboarding/pages/onboarding_summary_page.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Router App')),
      body: child, // router swaps this part
      bottomNavigationBar: Row(
        children: [
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: Icon(Icons.home),
          ),
          ElevatedButton(
            onPressed: () => context.go('/details'),
            child: Icon(Icons.details),
          ),
        ],
      ),
    );
  }
}

final GoRouter appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomeScreen(title: ''),
        ),
        GoRoute(path: '/details', builder: (context, state) => DetailsScreen()),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) {
            return BlocProvider(
              create: (_) => OnboardingCubit(getIt<OnboardingService>()),
              child: const OnboardingIntroPage(),
            );
          },
          routes: [
            GoRoute(
              path: 'permissions',
              builder: (context, state) {
                return BlocProvider.value(
                  value: context.read<OnboardingCubit>(),
                  child: const OnboardingPermissionsPage(),
                );
              },
            ),
            GoRoute(
              path: 'summary',
              builder: (context, state) {
                return BlocProvider.value(
                  value: context.read<OnboardingCubit>(),
                  child: const OnboardingSummaryPage(),
                );
              },
            ),
          ],
        ),
        GoRoute(path: '/auth', builder: (context, state) => const LoginPage()),
      ],
    ),
  ],
);
