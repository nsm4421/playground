import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sns/controller/auth_controller.dart';
import 'package:flutter_sns/model/user_dto.dart';
import 'package:flutter_sns/util/common_size.dart';
import 'package:flutter_sns/util/get_image_path.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  final String uid;

  const SignUpScreen({super.key, required this.uid});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? thumbnail;

  Widget _avatarWidget() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: SizedBox(
            width: 200,
            height: 200,
            child: thumbnail != null
                ? Image.file(
                    File(thumbnail!.path),
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    ImagePath.defaultProfile,
                    fit: BoxFit.cover,
                  )));
  }

  Widget _txtField(
      {String? hintText, required TextEditingController controller}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: CommonSize.marginXl, vertical: CommonSize.marginLg),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.all(CommonSize.paddingSm)),
      ),
    );
  }

  Widget _imagePickBtn() {
    return ElevatedButton(onPressed: handlePickImage, child: Text("프사 변경"));
  }

  Widget _submitBtn() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: CommonSize.marginXl, horizontal: CommonSize.paddingSm),
      child: ElevatedButton(onPressed: handleSignUp, child: Text("회원가입")),
    );
  }

  void handlePickImage() async {
    thumbnail =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 10);
    setState(() {});
  }

  void handleSignUp() async {
    await AuthController.to.signUp(
        dto: UserDto(
            uid: widget.uid,
            nickname: _nicknameController.text,
            description: _descriptionController.text),
        xFile: thumbnail);
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
            _avatarWidget(),
            SizedBox(
              height: CommonSize.marginLg,
            ),
            _imagePickBtn(),
            _txtField(hintText: "닉네임", controller: _nicknameController),
            _txtField(hintText: "자기소개", controller: _descriptionController),
          ],
        ),
      ),
      bottomNavigationBar: _submitBtn(),
    );
  }
}
