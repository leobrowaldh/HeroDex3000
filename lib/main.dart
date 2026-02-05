import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herodex/data/repositories/auth_repository.dart';
import 'package:herodex/injection.dart';
import 'package:herodex/presentation/auth/cubit/auth_cubit.dart';
import 'package:herodex/presentation/routing/router.dart';
import 'package:herodex/presentation/theme/app_theme.dart';
import 'package:herodex/presentation/theme/cubit/theme_cubit.dart';
import 'package:herodex/services/analytics_service.dart';
import 'package:herodex/services/crashlytics_service.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupDependencies();

  if (!kIsWeb) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => AuthRepository(
        firebaseAuth: FirebaseAuth.instance,
        analyticsService: getIt<AnalyticsService>(),
        crashlyticsService: getIt<CrashlyticsService>(),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (_) => getIt<ThemeCubit>()..loadTheme(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: appRouter,
              theme: AppTheme.getLightTheme(
                  isHighContrast: themeState.isHighContrast),
              darkTheme: AppTheme.getDarkTheme(
                  isHighContrast: themeState.isHighContrast),
              themeMode: themeState.themeMode,
            );
          },
        ),
      ),
    );
  }
}
