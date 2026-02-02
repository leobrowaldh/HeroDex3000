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
            const Text(
              'Välkommen till HeroDex 3000',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Efter invasionen behövs en ny generation hjältar. '
              'Låt oss sätta upp din terminal.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.go('/onboarding/permissions'),
              child: const Text('Starta'),
            ),
          ],
        ),
      ),
    );
  }
}
