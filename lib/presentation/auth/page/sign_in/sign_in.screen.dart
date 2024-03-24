import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constant/route.constant.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _View();
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

  _handleSignInWithEmailAndPassword() {}

  _handleGoToSignUpPage() {
    context.push(Routes.signUp.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _emailTextEditingController,
            ),
            TextField(
              controller: _passwordTextEditingController,
            ),
            ElevatedButton(
                onPressed: _handleSignInWithEmailAndPassword,
                child: const Text("Login")),
            ElevatedButton(
                onPressed: _handleGoToSignUpPage, child: const Text("SignUp"))
          ],
        ),
      ),
    );
  }
}
