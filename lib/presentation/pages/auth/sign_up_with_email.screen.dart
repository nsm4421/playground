import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/util/toast.util.dart';
import 'package:my_app/presentation/bloc/user/user.bloc.dart';
import 'package:my_app/presentation/components/error.fragment.dart';
import 'package:my_app/presentation/components/loading.fragment.dart';

class SignUpWithEmailAndPasswordScreen extends StatefulWidget {
  const SignUpWithEmailAndPasswordScreen({super.key});

  @override
  State<SignUpWithEmailAndPasswordScreen> createState() =>
      _SignUpWithEmailAndPasswordScreenState();
}

class _SignUpWithEmailAndPasswordScreenState
    extends State<SignUpWithEmailAndPasswordScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailTec;
  late TextEditingController _passwordTec;
  late TextEditingController _passwordConfirmTec;
  bool _isPasswordVisible = true;
  bool _isPasswordConfirmVisible = true;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailTec = TextEditingController();
    _passwordTec = TextEditingController();
    _passwordConfirmTec = TextEditingController();
  }

  @override
  dispose() {
    super.dispose();
    _emailTec.dispose();
    _passwordTec.dispose();
    _passwordConfirmTec.dispose();
  }

  String? _handleValidateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return '이메일을 입력해주세요';
    } else if (!(RegExp(r'^[^@]+@[^@]+\.[^@]+')).hasMatch(email)) {
      return '유효한 이메일을 입력해주세요';
    } else {
      return null;
    }
  }

  String? _handleValidatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return '비밀번호를 입력해주세요';
    } else if (password.length < 6) {
      return '비밀번호를 6자 이상 입력해주세요';
    } else {
      return null;
    }
  }

  String? _handleValidatePasswordConfirm(String? passwordConfirm) {
    if (passwordConfirm == null || passwordConfirm.isEmpty) {
      return '비밀번호 확인을 입력해주세요';
    } else if (passwordConfirm != _passwordTec.text.trim()) {
      return '비밀번호가 일치하지 않습니다';
    } else {
      return null;
    }
  }

  _handleClearEmail() => _emailTec.clear();

  _handlePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  _handlePasswordConfirmVisibility() {
    setState(() {
      _isPasswordConfirmVisible = !_isPasswordConfirmVisible;
    });
  }

  _handleSignUp() {
    final email = _emailTec.text.trim();
    final password = _passwordTec.text.trim();
    if (!_formKey.currentState!.validate()) {
      ToastUtil.toast('유효한 값을 입력해주세요');
      return;
    } else {
      context.read<UserBloc>().add(
          SignUpWithEmailAndPasswordEvent(email: email, password: password));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listenWhen: (prev, curr) {
        return (prev is NotAuthenticatedState) && (curr is OnBoardingState);
      },
      listener: (context, state) {
        if (state is OnBoardingState && context.mounted) {
          context.pop();
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (BuildContext context, state) {
          if (state is UserLoadingState) {
            return const LoadingFragment();
          } else if (state is UserFailureState) {
            return const ErrorFragment();
          }
          return Scaffold(
            appBar: AppBar(title: const Text("회원가입")),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // 이메일
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: TextFormField(
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(decorationThickness: 0),
                          controller: _emailTec,
                          validator: _handleValidateEmail,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email),
                              labelText: "이메일",
                              suffixIcon: IconButton(
                                  onPressed: _handleClearEmail,
                                  icon: const Icon(Icons.clear))),
                        )),

                    // 비밀번호
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: TextFormField(
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(decorationThickness: 0),
                          controller: _passwordTec,
                          validator: _handleValidatePassword,
                          obscureText: _isPasswordVisible,
                          decoration: InputDecoration(
                              labelText: "비밀번호",
                              helperText: "6자 이상으로 작명해주세요",
                              prefixIcon: const Icon(Icons.key),
                              suffixIcon: IconButton(
                                  onPressed: _handlePasswordVisibility,
                                  icon: _isPasswordVisible
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility))),
                        )),

                    // 비밀번호 확인
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: TextFormField(
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(decorationThickness: 0),
                          controller: _passwordConfirmTec,
                          validator: _handleValidatePasswordConfirm,
                          obscureText: _isPasswordConfirmVisible,
                          decoration: InputDecoration(
                              labelText: "비밀번호 확인",
                              helperText: "비밀번호를 다시 입력해주세요",
                              prefixIcon: const Icon(Icons.key_rounded),
                              suffixIcon: IconButton(
                                  onPressed: _handlePasswordConfirmVisibility,
                                  icon: _isPasswordConfirmVisible
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility))),
                        )),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton.extended(
              label: const Text("회원가입"),
              onPressed: _handleSignUp,
            ),
          );
        },
      ),
    );
  }
}
