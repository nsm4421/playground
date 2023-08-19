import 'package:chat_app/common/routes/routes.dart';
import 'package:chat_app/common/widget/w_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _handleSignUp(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      CustomRoutes.addPhoneNumber,
      (route) => false,
    );
  }

// TODO : 로그인 처리
  void _handleSignIn() {}

  Widget _title() {
    const double fontSizeLg = 45;
    const double fontSizeMd = 30;
    const double marginSize = 30;
    return Column(
      children: [
        Text(
          "Karma",
          style: GoogleFonts.lobsterTwo(fontSize: fontSizeLg),
        ),
        const Height(height: marginSize),
        Text(
          "Welcome to chat app",
          style: GoogleFonts.lobsterTwo(fontSize: fontSizeMd),
        ),
      ],
    );
  }

  Widget _buttons(BuildContext context) {
    const double buttonTextSize = 18;
    const double marginSize = 10;
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            _handleSignUp(context);
          },
          child: const SizedBox(
            width: 100,
            child: Center(
              child: Text(
                "회원가입하기",
                style: TextStyle(
                    fontSize: buttonTextSize, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        const Height(height: marginSize),
        ElevatedButton(
          onPressed: _handleSignIn,
          child: const SizedBox(
            width: 100,
            child: Center(
              child: Text(
                "로그인하기",
                style: TextStyle(
                    fontSize: buttonTextSize, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Divider(),
    );
  }

  Widget _footer() {
    return const Text(
      "nsm4421@gmail.com",
      style: TextStyle(color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double marginSize = 30;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const Height(height: marginSize),
              _title(),
              // TODO : 앱 로고 이미지 넣기
              const Expanded(child: SizedBox()),
              _buttons(context),
              _divider(),
              _footer(),
              const Height(height: marginSize)
            ],
          ),
        ),
      ),
    );
  }
}
