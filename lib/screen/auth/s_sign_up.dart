import 'package:flutter/material.dart';
import 'package:flutter_sns/controller/auth_controller.dart';
import 'package:flutter_sns/model/user_dto.dart';
import 'package:flutter_sns/util/common_size.dart';

class SignUpScreen extends StatefulWidget {
  final String uid;

  const SignUpScreen({super.key, required this.uid});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Widget _avatarWidget() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100), color: Colors.blueGrey),
      child: SizedBox(
        child: Icon(
          Icons.person,
          size: 100,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _txtField(
      {String? hintText, required TextEditingController controller}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: CommonSize.marginLg, vertical: CommonSize.marginLg),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.all(CommonSize.paddingSm)),
      ),
    );
  }

  Widget _submitBtn() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: CommonSize.marginXl, horizontal: CommonSize.paddingSm),
      child: ElevatedButton(onPressed: handleSignUp, child: Text("회원가입")),
    );
  }

  void handleSignUp() async {
    bool isSuccess = await AuthController.to.signUp(UserDto(
        uid: widget.uid,
        nickname: _nicknameController.text,
        description: _descriptionController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("회원가입"),
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: CommonSize.fontsizeXl,
            color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: CommonSize.margin2Xl,
            ),
            Center(
              child: Column(
                children: [
                  _avatarWidget(),
                  SizedBox(
                    height: CommonSize.marginXl,
                  ),
                  ElevatedButton(onPressed: () {}, child: Text("이미지 변경")),
                  _txtField(hintText: "닉네임", controller: _nicknameController),
                  _txtField(
                      hintText: "자기소개", controller: _descriptionController),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: _submitBtn(),
    );
  }
}
