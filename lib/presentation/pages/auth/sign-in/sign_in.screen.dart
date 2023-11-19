import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  _handleGoToSignUpPage() => context.push("/sign-up");

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "로그인",
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: _handleGoToSignUpPage,
                icon: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).colorScheme.primary,
                ))
          ],
          elevation: 0,
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [],
            ),
          ),
        ),
      );
}
