import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:herodex/presentation/onboarding/cubit/onboarding_cubit.dart';

class OnboardingSummaryPage extends StatelessWidget {
  const OnboardingSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingCompleted) {
          if (!context.mounted) return;
          context.go('/auth');
        }
      },
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              context.read<OnboardingCubit>().completeOnboarding();
            },
            child: const Text('Klar!'),
          ),
        ),
      ),
    );
  }
}
