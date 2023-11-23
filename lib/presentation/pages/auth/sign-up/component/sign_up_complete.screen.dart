import 'package:flutter/material.dart';

class SignUpCompleteScreen extends StatelessWidget {
  const SignUpCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Text("로그인 화면으로", style: Theme.of(context).textTheme.displayLarge),
      );
}
