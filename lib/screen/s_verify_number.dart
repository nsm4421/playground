import 'package:chat_app/common/widget/w_size.dart';
import 'package:chat_app/common/widget/w_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyNumberScreen extends StatefulWidget {
  const VerifyNumberScreen(
      {super.key, required this.countryCode, required this.phoneNumber});

  final String countryCode;
  final String phoneNumber;

  @override
  State<VerifyNumberScreen> createState() => _VerifyNumberScreenState();
}

class _VerifyNumberScreenState extends State<VerifyNumberScreen> {
  late TextEditingController _verifyNumberController;

  @override
  initState() {
    super.initState();
    _verifyNumberController = TextEditingController();
  }

  // TODO : 뒤로가기
  _handleClickBackButton() {}

  AppBar _appBar() {
    return AppBar(
      leading: InkWell(
        onTap: _handleClickBackButton,
        child: const Icon(Icons.arrow_back_ios),
      ),
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
          Text("+${widget.countryCode} ${widget.phoneNumber} 로 인증문자를 보냈습니다"),
        ],
      ),
    );
  }

  Widget _verifyNumberTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: CustomTextField(
        controller: _verifyNumberController,
        hintText: "- - - - - -",
        fontSize: 20,
        autoFocus: true,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          // TODO - 6자리 입력하면 다음 단계로 넘어가기
          if (value.length == 6) {}
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: Column(
          children: [
            _header(),
            const Height(height: 20),
            _verifyNumberTextField()
          ],
        ),
      ),
    );
  }
}
