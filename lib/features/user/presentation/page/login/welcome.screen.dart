import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constant/route.constant.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  goToLoginPage() => context.push(Routes.login.path);

  goToSignUpPage() => context.push(Routes.signUp.path);

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
                    "Welcome",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(
                  thickness: 1,
                ),
                ElevatedButton(
                  onPressed: goToLoginPage,
                  child: Center(
                    child: Text(
                      "로그인 페이지로",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Divider(
                  indent: 30,
                  endIndent: 30,
                  thickness: 1,
                  color: Colors.blueGrey,
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: goToSignUpPage,
                  child: Center(
                    child: Text(
                      "전화번호로 회원가입하기",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: (){
                    context.go(Routes.home.path);
                  },
                  child: Center(
                    child: Text(
                      "TEST",
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
