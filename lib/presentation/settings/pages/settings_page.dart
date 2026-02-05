import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
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
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, themeState) {
                  final isDark = themeState.themeMode == ThemeMode.dark;
                  return Column(
                    children: [
                      SwitchListTile(
                        title: const Text('Dark Mode'),
                        subtitle: const Text('Enable dark theme'),
                        secondary: const Icon(Icons.dark_mode),
                        value: isDark,
                        onChanged: (value) {
                          context.read<ThemeCubit>().toggleTheme(value);
                        },
                      ),
                      SwitchListTile(
                        title: const Text('High Contrast Mode'),
                        subtitle: const Text('Increase visibility'),
                        secondary: const Icon(Icons.contrast),
                        value: themeState.isHighContrast,
                        onChanged: (value) {
                          context
                              .read<ThemeCubit>()
                              .toggleHighContrast(value);
                        },
                      ),
                    ],
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
              if (Platform.isIOS) ...[
                const Divider(),
                _buildSectionHeader(context, 'App Tracking Transparency (iOS only)'),
                ListTile(
                  leading: const Icon(Icons.privacy_tip),
                  title: const Text('Tracking Status'),
                  trailing: Text(
                    state.attStatus ?? 'unknown',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Open iOS Settings'),
                  subtitle: const Text('Manage tracking permissions in system settings'),
                  onTap: () => openAppSettings(),
                ),
              ],

          const Divider(),
          _buildSectionHeader(context, 'HeroDex 3000-info'),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Version'),
            trailing: const Text(
              '1.0',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Creator'),
            trailing: const Text(
              'Leo Browaldh',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Year'),
            trailing: const Text(
              '2026',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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
