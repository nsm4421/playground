import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/core/util/toast.util.dart';
import 'package:hot_place/presentation/auth/bloc/auth.bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is InitialAuthState || state is AuthSuccessState) {
          return const _View();
        } else if (state is AuthLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AuthFailureState) {
          return _OnError(state.message);
        } else {
          return const _OnError("ERROR");
        }
      },
      listener: (BuildContext context, AuthState state) {
        // TODO : 회원가입 성공 시, 로그인페이지로
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
  late TextEditingController _nicknameTextEditingController;

  @override
  void initState() {
    super.initState();
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _nicknameTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _nicknameTextEditingController.dispose();
  }

  _handleSignUpWithEmailAndPassword() {
    final email = _emailTextEditingController.text.trim();
    final password = _passwordTextEditingController.text.trim();
    final nickname = _nicknameTextEditingController.text.trim();
    if (email.isEmpty || password.isEmpty || nickname.isEmpty) {
      ToastUtil.toast('Check Input Again');
      return;
    }
    context.read<AuthBloc>().add(SignUpWithEmailAndPasswordEvent(
        email: email, password: password, nickname: nickname));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 이메일
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TextField(
                maxLength: 30,
                style:
                    const TextStyle(decorationThickness: 0, letterSpacing: 2),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                controller: _emailTextEditingController,
              ),
            ),
            // 비밀번호
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TextField(
                maxLength: 30,
                obscureText: true,
                style:
                    const TextStyle(decorationThickness: 0, letterSpacing: 2),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.key),
                  border: OutlineInputBorder(),
                ),
                controller: _passwordTextEditingController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TextField(
                maxLength: 30,
                style:
                    const TextStyle(decorationThickness: 0, letterSpacing: 2),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.account_circle),
                  border: OutlineInputBorder(),
                ),
                controller: _nicknameTextEditingController,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: _handleSignUpWithEmailAndPassword,
          label: Text(
            "NEXT",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class _OnError extends StatelessWidget {
  const _OnError(this.message);

  final String message;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message, style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(InitAuthEvent());
                  },
                  child: const Text("Initialize"))
            ],
          ),
        ),
      );
}
