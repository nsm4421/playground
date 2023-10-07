import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/repository/auth_repository.dart';
import 'package:chat_app/utils/alert_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

class AuthController {
  final AuthRepository _authRepository;
  final ProviderRef _ref;

  AuthController({
    required AuthRepository authRepository,
    required ProviderRef<dynamic> ref,
  }) : _authRepository = authRepository, _ref = ref;

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

  /// 구글계정으로 회원가입하기
  signUpWithGoogle(BuildContext context) async {
    try {
      final credential = await _authRepository.signUpWithGoogle();
      if (credential.user == null) {
        if (context.mounted) {
          AlertUtils.showSnackBar(context, 'google sign in failed');
        }
        return;
      }
      if (context.mounted) {
        AlertUtils.showSnackBar(context, 'google success');
        context.go("/");
      }
    } catch (e) {
      AlertUtils.showSnackBar(context, 'google sign in failed...');
      return;
    }
  }

  /// 회원가입 페이지로 이동하기
  goToSignUpPage(BuildContext context) => context.push("/sign_up");

  /// 로그인 처리하기
  loginWithEmailAndPassword({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailTEC,
    required TextEditingController passwordTEC,
  }) async {
    try {
      // 입력값 체크하기
      if (!_checkForm(context: context, formKey: formKey)) return;

      // 로그인 처리하기
      final credential = await _authRepository.loginWithEmailAndPassword(
        emailTEC.text,
        passwordTEC.text,
      );

      if (credential.user == null) {
        if (context.mounted) {
          AlertUtils.showSnackBar(context, 'user not found...');
        }
        return;
      }

      if (context.mounted) {
        AlertUtils.showSnackBar(context, 'login success');
        context.go("/");
      }
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

  /// 회원가입 처리하기
  signUpWithEmailAndPassword({
    required BuildContext context,
    required XFile xFile,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailTEC,
    required TextEditingController passwordTEC,
    required TextEditingController passwordConfirmTEC,
    required TextEditingController usernameTEC,
  }) async {
    try {
      // check input
      if (!formKey.currentState!.validate()) return;
      formKey.currentState!.save();

      // check username is duplicated or not
      final username = usernameTEC.text.trim();
      final isUsernameDuplicated =
          await _authRepository.isUsernameDuplicated(username);
      if (isUsernameDuplicated) {
        if (context.mounted) {
          AlertUtils.showSnackBar(context, '이미 사용중인 유저명입니다');
        }
        throw Exception();
      }

      // handle sign up
      final credential = await _authRepository.signUpWithEmailAndPassword(
        emailTEC.text.trim(),
        passwordTEC.text.trim(),
      );
      final uid = credential.user?.uid;
      if (uid == null) {
        if (context.mounted) {
          AlertUtils.showSnackBar(context, '회원가입에 실패하였습니다');
        }
        throw Exception();
      }

      // save user info in firestore
      final downloadLink = await _authRepository.saveProfileImageInStorage(
          uid: uid, xFile: xFile);
      final user = UserModel(
        uid: uid,
        username: usernameTEC.text.trim(),
        email: emailTEC.text.trim(),
        profileUrl: downloadLink,
        lastSeen: DateTime.now(),
        createdAt: DateTime.now(),
      );
      final isSuccess = await _authRepository.saveUserInDB(user);
      if (!isSuccess) {
        if (context.mounted) {
          AlertUtils.showSnackBar(context, '회원가입은 성공했으나, 회원정보 저장에 실패하였습니다');
        }
        throw Exception();
      }
      // on success
      if (context.mounted) {
        AlertUtils.showSnackBar(context, 'success');
        context.go('/login');
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "weak-password":
          AlertUtils.showSnackBar(context, 'password is weak');
          return;
        case "email-already-in-use":
          AlertUtils.showSnackBar(context, 'email is already in user');
          return;
        default:
          AlertUtils.showSnackBar(context, 'error occurs');
          return;
      }
    } catch (e) {
      AlertUtils.showSnackBar(context, 'internal server error');
      return;
    }
  }
}
