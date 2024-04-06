import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/core/util/toast.util.dart';
import 'package:hot_place/presentation/auth/bloc/auth.bloc.dart';
import 'package:hot_place/presentation/auth/widget/text_field.widget.dart';

import '../../widget/auth_error.widget.dart';
import '../../widget/loading.widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is InitialAuthState || state is AuthSuccessState) {
          return const _View();
        } else if (state is AuthLoadingState) {
          return const LoadingWidget("회원가입 처리중입니다");
        } else if (state is AuthFailureState) {
          return AuthErrorWidget(state.message);
        } else {
          return const AuthErrorWidget("회원가이 중 에러가 발생했습니다");
        }
      },
    );
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
  late TextEditingController _passwordConfirmTextEditingController;
  late TextEditingController _nicknameTextEditingController;

  @override
  void initState() {
    super.initState();
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _passwordConfirmTextEditingController = TextEditingController();
    _nicknameTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _passwordConfirmTextEditingController.dispose();
    _nicknameTextEditingController.dispose();
  }

  // 회원가입 처리
  _handleSignUpWithEmailAndPassword() {
    final email = _emailTextEditingController.text.trim();
    final password = _passwordTextEditingController.text.trim();
    final passwordConfirm = _passwordConfirmTextEditingController.text.trim();
    final nickname = _nicknameTextEditingController.text.trim();
    // 필드값 검사
    if (email.isEmpty ||
        password.isEmpty ||
        passwordConfirm.isEmpty ||
        nickname.isEmpty) {
      ToastUtil.toast('빈값을 입력했습니다');
      return;
    } else if (password != passwordConfirm) {
      ToastUtil.toast('비밀번호가 서로 일치하지 않습니다');
      return;
    }
    // 회원가입처리
    // TODO : 프로필 이미지 선택 및 저장 기능 추가 구현하기
    context.read<AuthBloc>().add(SignUpWithEmailAndPasswordEvent(
        email: email, password: password, nickname: nickname, profileUrl: ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("회원가입"),
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: PasswordTextField(
                _passwordTextEditingController,
                hintText: "비밀번호를 입력해주세요",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: PasswordTextField(
                _passwordConfirmTextEditingController,
                hintText: "비밀번호를 다시 입력해주세요",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: NicknameTextField(_nicknameTextEditingController),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: _handleSignUpWithEmailAndPassword,
          label: Text(
            "Submit",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
