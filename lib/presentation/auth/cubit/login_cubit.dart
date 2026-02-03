import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:herodex/data/repositories/auth_repository.dart';
import 'package:herodex/presentation/auth/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    try {
      await _authRepository.signIn(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      String message = 'Login failed. Please try again.';
      
      switch (e.code) {
        case 'user-not-found':
          message = 'No account found with that email.';
          break;
        case 'wrong-password':
          message = 'Incorrect password. Please try again.';
          break;
        case 'invalid-email':
          message = 'Please enter a valid email address.';
          break;
        case 'invalid-credential':
          message = 'Incorrect email or password.';
          break;
        default:
          message = e.message ?? 'An unknown error occurred.';
      }

      emit(LoginFailure(message));
    } on AuthFailure catch (e) {
      emit(LoginFailure(e.message));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
