import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingIntroPage extends StatelessWidget {
  const OnboardingIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.terminal, size: 80),
            const SizedBox(height: 24),
            const Text(
              'Welcome to HeroDex 3000',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Think of a hero — any hero — and add them to your growing roster.\n\nMeasure your team’s power and shape your own legendary squad.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(200, 50)),
              onPressed: () => context.go('/onboarding/permissions'),
              child: const Text('Start Setup'),
            ),
          ],
        ),
      ),
    );
  }
}
