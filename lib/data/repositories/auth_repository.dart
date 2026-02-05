import 'package:firebase_auth/firebase_auth.dart';
import 'package:herodex/services/analytics_service.dart';
import 'package:herodex/services/crashlytics_service.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final AnalyticsService _analyticsService;
  final CrashlyticsService _crashlyticsService;

  AuthRepository({
    required FirebaseAuth firebaseAuth,
    required AnalyticsService analyticsService,
    required CrashlyticsService crashlyticsService,
  }) : _firebaseAuth = firebaseAuth,
       _analyticsService = analyticsService,
       _crashlyticsService = crashlyticsService;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signIn({required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _analyticsService.logLoginPassword();
      await _crashlyticsService.setUserId(userCredential.user!.uid);
    } on FirebaseAuthException catch (e, stackTrace) {
      await _crashlyticsService.recordError(e, stackTrace);
      switch (e.code) {
        case 'invalid-email':
          throw AuthFailure('The email address is not valid.');
        case 'user-not-found':
          throw AuthFailure('No account found with that email.');
        case 'wrong-password':
          throw AuthFailure('Incorrect password. Please try again.');
        case 'user-disabled':
          throw AuthFailure('This account has been disabled.');
        case 'too-many-requests':
          throw AuthFailure(
            'Too many login attempts. Please wait and try again.',
          );
        default:
          throw AuthFailure('Login failed. Please try again.');
      }
    } catch (e, stackTrace) {
      await _crashlyticsService.recordError(e, stackTrace);
      throw AuthFailure('An unexpected error occurred during login.');
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

class AuthFailure implements Exception {
  final String message;
  AuthFailure(this.message);

  @override
  String toString() => message;
}
