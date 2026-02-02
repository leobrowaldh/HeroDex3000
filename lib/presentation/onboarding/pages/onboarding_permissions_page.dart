import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingPermissionsPage extends StatefulWidget {
  const OnboardingPermissionsPage({super.key});

  @override
  State<OnboardingPermissionsPage> createState() =>
      _OnboardingPermissionsPageState();
}

class _OnboardingPermissionsPageState extends State<OnboardingPermissionsPage> {
  bool analytics = true;
  bool crashlytics = true;
  bool location = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Behörigheter')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Analytics'),
              value: analytics,
              onChanged: (v) => setState(() => analytics = v),
            ),
            SwitchListTile(
              title: const Text('Crashlytics'),
              value: crashlytics,
              onChanged: (v) => setState(() => crashlytics = v),
            ),
            SwitchListTile(
              title: const Text('Location (VG)'),
              value: location,
              onChanged: (v) => setState(() => location = v),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => context.go('/onboarding/summary'),
              child: const Text('Fortsätt'),
            ),
          ],
        ),
      ),
    );
  }
}
