import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/presentation/bloc/user/auth/auth.cubit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

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
  _handleGoogleSignIn() => context.read<AuthCubit>().signInWithGoogle();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LOGIN")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: _handleGoogleSignIn, child: Text("구글계정을 회원가입"))
          ],
        ),
      ),
    );
  }
}
