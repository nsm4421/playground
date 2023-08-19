import 'package:chat_app/common/widget/w_size.dart';
import 'package:chat_app/common/widget/w_text_feild.dart';
import 'package:chat_app/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyNumberScreen extends ConsumerWidget {
  const VerifyNumberScreen(
      {super.key, required this.smsCodeId, required this.phoneNumber});

  final String smsCodeId;
  final String phoneNumber;

  void _handleVerifySmsCode({
    required BuildContext context,
    required WidgetRef ref,
    required String smsCode,
  }) {
    ref.read(authControllerProvider).verifySmsCode(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: true);
  }

  AppBar _appBar() {
    return AppBar(
      leading: const Icon(Icons.arrow_back_ios),
      title: Text(
        "Verify",
        style: GoogleFonts.lobster(fontSize: 30),
      ),
      titleSpacing: 2,
      centerTitle: true,
    );
  }

  Widget _header() {
    return Center(
      child: Column(
        children: [
          const Height(height: 30),
          const Text(
            "전화번호 인증",
            style: TextStyle(fontSize: 25),
          ),
          const Height(height: 50),
          Text("$phoneNumber 로 인증문자를 보냈습니다"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: Column(
          children: [
            _header(),
            const Height(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: CustomTextField(
                hintText: "- - - - - -",
                fontSize: 20,
                autoFocus: true,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  // TODO - 6자리 입력하면 다음 단계로 넘어가기
                  if (value.length == 6) {
                    _handleVerifySmsCode(
                        context: context, ref: ref, smsCode: value);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
