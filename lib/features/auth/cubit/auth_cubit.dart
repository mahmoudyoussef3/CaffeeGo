import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../data/authentication_methods.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signInWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      final UserCredential? result = await AuthenticationMethods()
          .signInWithEmailAndPassword(email, password);
      if (result != null && result.user != null) {
        emit(AuthSuccess(result.user!));
      } else {
        emit(AuthError('Login failed. Please try again.'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'An unknown error occurred.'));
    }
  }

  void signInWithGoogle() async {
    emit(AuthLoading());
    try {
      final UserCredential result =
          await AuthenticationMethods().signInWithGoogle();
      emit(AuthSuccess(result.user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message!));
    }
  }

  void createAccount(String email, String password, String phoneNumber,
      String fullName) async {
    emit(AuthLoading());
    try {
      final UserCredential? result = await AuthenticationMethods()
          .createAccountWithEmailAndPassword(
              email, password, phoneNumber, fullName);
      if (result != null && result.user != null) {
        emit(AuthSuccess(result.user!));
      } else {
        emit(AuthError('Login failed. Please try again.'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message!));
    }
  }
}
