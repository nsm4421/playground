import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:go_router/go_router.dart';

import '../../../app/constant/route.constant.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  static const _otpLength = 6;
  final TextEditingController _otpTextEditingController =
      TextEditingController();
  bool _isAuthorized = false;

  _goToOnBoardingPage() {
    // TODO : 인증여부 판단
    context.push(Routes.onboarding.path);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("OTP"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            const Center(child: Text("인증번호를 발송하였습니다")),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: <Widget>[
                  PinCodeFields(
                    controller: _otpTextEditingController,
                    length: _otpLength,
                    onComplete: (String pinCode) {},
                  ),
                  if (_otpTextEditingController.text.length < _otpLength)
                    const Text("OTP번호를 입력해주세요")
                ],
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: _goToOnBoardingPage,
            label: Text(
              "NEXT",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            )),
      );
}
