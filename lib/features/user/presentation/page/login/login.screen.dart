import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constant/route.constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TODO
  handleGoogleSignIn() {}

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Login",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 25),
                const Divider(
                  indent: 30,
                  endIndent: 30,
                  thickness: 1,
                  color: Colors.blueGrey,
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: handleGoogleSignIn,
                  child: Center(
                    child: Text(
                      "Google 계정으로 로그인하기",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
