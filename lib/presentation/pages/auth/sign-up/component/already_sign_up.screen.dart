import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constant/enums/routes.enum.dart';

class AlreadySignUpScreen extends StatefulWidget {
  const AlreadySignUpScreen({super.key});

  @override
  State<AlreadySignUpScreen> createState() => _AlreadySignUpScreenState();
}

class _AlreadySignUpScreenState extends State<AlreadySignUpScreen> {
  _handleGoToLoginPage() => context.go(Routes.signIn.path);

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("이미 회원가입 하였습니다",
                style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 50)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleGoToLoginPage,
        label: Text("Login페이지로",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold)),
      ));
}
