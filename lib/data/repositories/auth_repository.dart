import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseAnalytics _analytics;

  AuthRepository({
    required FirebaseAuth firebaseAuth,
    required FirebaseAnalytics analytics,
  }) : _firebaseAuth = firebaseAuth,
       _analytics = analytics;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (Platform.isAndroid || Platform.isIOS) {
        await _analytics.logLogin(loginMethod: "password");
      }
    } on FirebaseAuthException catch (e) {
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
    } catch (_) {
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
}
