import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _View();
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

  _handleSignUpWithEmailAndPassword(){}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: _emailTextEditingController,
          ),
          TextField(
            controller: _passwordTextEditingController,
          ),
          TextField(
            controller: _nicknameTextEditingController,
          ),
          ElevatedButton(onPressed: _handleSignUpWithEmailAndPassword, child: const Text("Sign Up"))
        ],
      ),
    );
  }
}
