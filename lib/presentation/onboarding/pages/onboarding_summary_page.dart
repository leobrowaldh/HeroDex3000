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
          context.go('/auth');
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Setup Complete')),
        body: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 100,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'You are ready!',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Here is a summary of your configuration:',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  _buildSummaryItem(
                    context,
                    'Analytics',
                    state.analytics ? 'Enabled' : 'Disabled',
                  ),
                  _buildSummaryItem(
                    context,
                    'Crashlytics',
                    state.crashlytics ? 'Enabled' : 'Disabled',
                  ),
                  _buildSummaryItem(
                    context,
                    'Location',
                    state.location ? 'Enabled' : 'Disabled',
                  ),
                  const SizedBox(height: 48),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                    ),
                    onPressed: () {
                      context.read<OnboardingCubit>().completeOnboarding();
                    },
                    child: const Text('Initialize Terminal'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSummaryItem(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            value,
            style: TextStyle(
              color: value == 'Enabled'
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}
