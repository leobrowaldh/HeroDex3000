import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:herodex/presentation/onboarding/cubit/onboarding_cubit.dart';

class OnboardingPermissionsPage extends StatelessWidget {
  const OnboardingPermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('System Permissions')),
      body: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Configure your terminal for maximum efficiency.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 32),

                _buildSwitch(
                  title: 'Analytics',
                  subtitle: 'Help us improve by sending usage data.',
                  value: state.analytics,
                  onChanged: (v) =>
                      context.read<OnboardingCubit>().setAnalytics(v),
                ),
                const Divider(),

                _buildSwitch(
                  title: 'Crashlytics',
                  subtitle: 'Send crash reports automatically.',
                  value: state.crashlytics,
                  onChanged: (v) =>
                      context.read<OnboardingCubit>().setCrashlytics(v),
                ),
                const Divider(),

                _buildSwitch(
                  title: 'Location (Optional)',
                  subtitle: 'Enable location services for better intel.',
                  value: state.location,
                  onChanged: (v) =>
                      context.read<OnboardingCubit>().setLocation(v),
                ),

                const Spacer(),

                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                    ),
                    onPressed: () => context.go('/onboarding/summary'),
                    child: const Text('Continue'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.blueAccent,
    );
  }
}
