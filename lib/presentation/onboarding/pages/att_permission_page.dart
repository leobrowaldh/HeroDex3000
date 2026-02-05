import 'package:herodex/injection.dart';
import 'package:herodex/services/platform_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:herodex/presentation/onboarding/cubit/onboarding_cubit.dart';

class AttPermissionPage extends StatefulWidget {
  const AttPermissionPage({super.key});

  @override
  State<AttPermissionPage> createState() => _AttPermissionPageState();
}

class _AttPermissionPageState extends State<AttPermissionPage> {
  late final PlatformService _platformService;

  @override
  void initState() {
    super.initState();
    _platformService = getIt<PlatformService>();
    
    // If not iOS, skip directly to permissions
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_platformService.isIOS) {
        context.go('/onboarding/permissions');
      }
    });
  }

  Future<void> _handleContinue() async {
    final status = await AppTrackingTransparency.requestTrackingAuthorization();
    if (!mounted) return;
    
    final cubit = context.read<OnboardingCubit>();
    await cubit.setAttStatus(status.name);
    
    if (!mounted) return;
    context.go('/onboarding/permissions');
  }

  @override
  Widget build(BuildContext context) {
    if (!_platformService.isIOS) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Privacy')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.security, size: 80, color: Colors.blue),
            const SizedBox(height: 32),
            const Text(
              'App Tracking Transparency',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'HeroDex requests permission to track your activity across other companies’ apps and websites. This help us provide a more personalized experience and improve our Hero indexing algorithms.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: _handleContinue,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
