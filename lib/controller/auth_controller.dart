import 'package:chat_app/repository/auth_repository.dart';
import 'package:chat_app/utils/alert_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({
    required this.authRepository,
    required this.ref,
  });

  signUpWithGoogle(BuildContext context) async {
    try {
      await authRepository.signUpWithGoogle().then((credit) {
        if (credit.user == null) {
          AlertUtils.showSnackBar(context, 'google sign in failed');
          return;
        }
        AlertUtils.showSnackBar(context, 'google success');
        context.go("/");
      });
    } catch (e) {
      AlertUtils.showSnackBar(context, 'google sign in failed...');
      return;
    }
  }

  goToSignUpPage(BuildContext context) => context.push("/sign_up");

  bool _checkForm({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
  }) {
    if (!formKey.currentState!.validate()) {
      AlertUtils.showSnackBar(context, 'check input again');
      return false;
    }
    formKey.currentState!.save();
    return true;
  }

  loginWithEmailAndPassword({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailTEC,
    required TextEditingController passwordTEC,
  }) async {
    try {
      // check input
      if (!_checkForm(context: context, formKey: formKey)) return;
      // login
      await authRepository
          .loginWithEmailAndPassword(emailTEC.text, passwordTEC.text)
          .then((credential) {
        if (credential.user == null) {
          AlertUtils.showSnackBar(context, 'user not found...');
          return;
        }
        AlertUtils.showSnackBar(context, 'login success');
        context.go("/");
      });
    }
    // on firebase error
    on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-founded":
          AlertUtils.showSnackBar(
              context, '${emailTEC.text}\n is not registered');
          return;
        case "wrong-password":
          AlertUtils.showSnackBar(context, 'password is wrong');
          return;
        default:
          AlertUtils.showSnackBar(context, 'firebase auth error...');
          return;
      }
    }
    // on error
    catch (e) {
      AlertUtils.showSnackBar(context, 'login failed');
      return;
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailTEC,
    required TextEditingController passwordTEC,
    required TextEditingController passwordConfirmTEC,
  }) async {
    try {
      if (!formKey.currentState!.validate()) {
        AlertUtils.showSnackBar(context, 'check input again');
        return;
      }
      formKey.currentState!.save();
      if (passwordTEC.text != passwordConfirmTEC.text) {
        AlertUtils.showSnackBar(context, 'password are not matched');
        return;
      }

      await authRepository
          .signUpWithEmailAndPassword(emailTEC.text, passwordTEC.text)
          .then((credential) async =>
              await authRepository.saveUserInDB(credential));

      if (context.mounted) {
        AlertUtils.showSnackBar(context, 'success');
        context.go('/login');
        return;
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "weak-password":
          AlertUtils.showSnackBar(context, 'password is too weak...');
          return;
        case "email-already-in-use":
          AlertUtils.showSnackBar(context, 'email is already in use...');
          return;
        default:
          AlertUtils.showSnackBar(context, 'firebase auth error...');
          return;
      }
    } catch (e) {
      AlertUtils.showSnackBar(context, 'unknown error...');
      return;
    }
  }
}
