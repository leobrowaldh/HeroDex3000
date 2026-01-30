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
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Only log analytics on mobile platforms
    if (Platform.isAndroid || Platform.isIOS) {
      await _analytics.logLogin(loginMethod: "password");
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
