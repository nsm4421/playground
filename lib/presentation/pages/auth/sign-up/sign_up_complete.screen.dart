import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constant/enums/routes.enum.dart';

class SignUpCompleteScreen extends StatefulWidget {
  const SignUpCompleteScreen({super.key});

  @override
  State<SignUpCompleteScreen> createState() => _SignUpCompleteScreenState();
}

class _SignUpCompleteScreenState extends State<SignUpCompleteScreen> {
  _handleGoToLoginPage() => context.go(Routes.signIn.path);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50),
                Text("Complete",
                    style: GoogleFonts.lobsterTwo(
                        fontWeight: FontWeight.w700, fontSize: 50)),
                const SizedBox(height: 30),
                Text("앱을 사용하기 위한 모든 준비가 완료되었습니다",
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 20),
                Text("이제 채팅을 즐겨보세요",
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _handleGoToLoginPage,
          label: Text(
            "Login페이지로",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
}
