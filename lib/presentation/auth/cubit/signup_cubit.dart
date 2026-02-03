import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:herodex/data/repositories/auth_repository.dart';
import 'package:herodex/presentation/auth/cubit/signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;

  SignupCubit(this._authRepository) : super(SignupInitial());

  Future<void> signUp(String email, String password) async {
    emit(SignupLoading());

    try {
      await _authRepository.signUp(email: email, password: password);
      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      String message = 'Signup failed. Please try again.';

      switch (e.code) {
        case 'email-already-in-use':
          message = 'An account with this email already exists.';
          break;
        case 'invalid-email':
          message = 'Please enter a valid email address.';
          break;
        case 'weak-password':
          message = 'Your password is too weak.';
          break;
        default:
          message = e.message ?? 'An unknown error occurred.';
      }

      emit(SignupFailure(message));
    } on AuthFailure catch (e) {
      emit(SignupFailure(e.message));
    } catch (e) {
      emit(SignupFailure(e.toString()));
    }
  }
}
