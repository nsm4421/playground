import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/util/toast.util.dart';
import 'package:hot_place/presentation/auth/widget/text_field.widget.dart';

import '../../../../core/constant/route.constant.dart';
import '../../bloc/auth.bloc.dart';
import '../../widget/auth_error.widget.dart';
import '../../widget/loading.widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is InitialAuthState || state is AuthSuccessState) {
        return const _View();
      } else if (state is AuthLoadingState) {
        return const LoadingWidget("로그인 처리 중입니다");
      } else if (state is AuthFailureState) {
        return AuthErrorWidget(state.message);
      } else {
        return const AuthErrorWidget("로그인 처리 중 에러가 발생했습니다");
      }
    });
  }
}

class _View extends StatefulWidget {
  const _View({super.key});

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  late TextEditingController _emailTextEditingController;
  late TextEditingController _passwordTextEditingController;

  @override
  void initState() {
    super.initState();
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
  }

  // 로그인 처리
  _handleSignInWithEmailAndPassword() {
    final email = _emailTextEditingController.text.trim();
    final password = _passwordTextEditingController.text.trim();
    if (email.isEmpty) {
      ToastUtil.toast('이메일을 입력해주세요');
      return;
    } else if (password.isEmpty) {
      ToastUtil.toast('비밀번호를 입력해주세요');
      return;
    }
    context
        .read<AuthBloc>()
        .add(SignInWithEmailAndPasswordEvent(email: email, password: password));
  }

  // 회원가입 페이지로 이동
  _handleGoToSignUpPage() {
    context.push(Routes.signUp.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("로그인"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 이메일
            Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 30, bottom: 8),
              child: EmailTextField(_emailTextEditingController),
            ),

            // 비밀번호
            Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 8, bottom: 30),
              child: PasswordTextField(_passwordTextEditingController,
                  hintText: "비밀번호를 입력해주세요"),
            ),

            // 로그인
            GestureDetector(
                onTap: _handleSignInWithEmailAndPassword,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  width: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).colorScheme.primaryContainer),
                  child: Text("Login",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold)),
                )),

            // 회원가입 페이지로
            const SizedBox(height: 8),
            const Divider(indent: 15, endIndent: 15, thickness: 1),
            const SizedBox(height: 8),
            GestureDetector(
                onTap: _handleGoToSignUpPage,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  width: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).colorScheme.secondaryContainer),
                  child: Text("Sign Up",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold)),
                ))
          ],
        ),
      ),
    );
  }
}
