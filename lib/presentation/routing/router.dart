import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:herodex/domain/entities/hero_entity.dart';
import 'package:herodex/injection.dart';

// Pages
import 'package:herodex/presentation/home/pages/home_page.dart';
import 'package:herodex/presentation/auth/pages/login_page.dart';
import 'package:herodex/presentation/search/cubit/search_cubit.dart';
import 'package:herodex/presentation/search/pages/search_page.dart';
import 'package:herodex/presentation/saved/pages/saved_page.dart';
import 'package:herodex/presentation/settings/pages/settings_page.dart';
import 'package:herodex/presentation/hero_detail/pages/hero_detail_page.dart';

// Onboarding
import 'package:herodex/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:herodex/presentation/onboarding/services/onboarding_service.dart';
import 'package:herodex/presentation/onboarding/pages/onboarding_intro_page.dart';
import 'package:herodex/presentation/onboarding/pages/onboarding_permissions_page.dart';
import 'package:herodex/presentation/onboarding/pages/onboarding_summary_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
        GoRoute(
          path: '/search',
          builder: (context, state) {
            return BlocProvider(
              create: (_) => SearchCubit(getIt()),
              child: const SearchPage(),
            );
          },
        ),
        GoRoute(path: '/saved', builder: (context, state) => const SavedPage()),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsPage(),
        ),
      ],
    ),

    GoRoute(
      path: '/details',
      builder: (context, state) {
        final hero = state.extra as HeroEntity;
        return HeroDetailPage(hero: hero);
      },
    ),

    GoRoute(path: '/auth', builder: (context, state) => const LoginPage()),

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
  ],
);

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    int index = 0;
    if (location.startsWith('/search')) index = 1;
    if (location.startsWith('/saved')) index = 2;
    if (location.startsWith('/settings')) index = 3;

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          switch (i) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/search');
              break;
            case 2:
              context.go('/saved');
              break;
            case 3:
              context.go('/settings');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
