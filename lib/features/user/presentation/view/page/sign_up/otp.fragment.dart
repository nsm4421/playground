import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

class OtpFragment extends StatefulWidget {
  const OtpFragment({super.key});

  @override
  State<OtpFragment> createState() => _OtpFragmentState();
}

class _OtpFragmentState extends State<OtpFragment> {
  static const _otpLength = 6;
  final TextEditingController _otpTextEditingController =
      TextEditingController();
  bool _isAuthorized = false;

  _goToOnBoardingPage() {
    // TODO : 인증여부 판단
  }

  @override
  Widget build(BuildContext context) => Column(
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
      );
}
