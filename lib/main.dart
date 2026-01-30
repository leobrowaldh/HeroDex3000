import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herodex/data/repositories/auth_repository.dart';
import 'package:herodex/injection.dart';
import 'package:herodex/presentation/auth/cubit/auth_cubit.dart';
import 'package:herodex/presentation/auth/widgets/auth_flow.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => AuthRepository(
        firebaseAuth: FirebaseAuth.instance,
        analytics: FirebaseAnalytics.instance,
      ),

      child: BlocProvider(
        create: (context) => AuthCubit(context.read<AuthRepository>()),
        child: const AuthFlow(),
      ),
    );
  }
}
