import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herodex/injection.dart';
import 'package:herodex/presentation/settings/cubit/settings_cubit.dart';
import 'package:herodex/presentation/settings/cubit/settings_state.dart';
import 'package:herodex/presentation/theme/cubit/theme_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SettingsCubit>()..loadSettings(),
      child: const SettingsView(),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: [
              _buildSectionHeader(context, 'Appearance'),
              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, themeMode) {
                  final isDark = themeMode == ThemeMode.dark;
                  return SwitchListTile(
                    title: const Text('Dark Mode'),
                    subtitle: const Text('Enable dark theme'),
                    secondary: const Icon(Icons.dark_mode),
                    value: isDark,
                    onChanged: (value) {
                      context.read<ThemeCubit>().toggleTheme(value);
                    },
                  );
                },
              ),
              const Divider(),
              _buildSectionHeader(context, 'Privacy & Permissions'),
              SwitchListTile(
                title: const Text('Analytics'),
                subtitle: const Text('Share usage data to help us improve.'),
                secondary: const Icon(Icons.bar_chart),
                value: state.analytics,
                onChanged: (value) =>
                    context.read<SettingsCubit>().toggleAnalytics(value),
              ),
              SwitchListTile(
                title: const Text('Crashlytics'),
                subtitle: const Text('Automatically report crashes.'),
                secondary: const Icon(Icons.bug_report),
                value: state.crashlytics,
                onChanged: (value) =>
                    context.read<SettingsCubit>().toggleCrashlytics(value),
              ),
              SwitchListTile(
                title: const Text('Location'),
                subtitle: const Text('Enable location-based features.'),
                secondary: const Icon(Icons.location_on),
                value: state.location,
                onChanged: (value) =>
                    context.read<SettingsCubit>().toggleLocation(value),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
