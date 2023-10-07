import 'dart:typed_data';

import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/screen/widget/w_box.dart';
import 'package:chat_app/utils/image_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailTEC;
  late TextEditingController _passwordTEC;
  late TextEditingController _passwordConfirmTEC;
  late TextEditingController _usernameTEC;
  XFile? _xFile;
  Uint8List? _imageData;

  @override
  void initState() {
    super.initState();
    _emailTEC = TextEditingController();
    _passwordTEC = TextEditingController();
    _passwordConfirmTEC = TextEditingController();
    _usernameTEC = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEC.dispose();
    _passwordTEC.dispose();
    _passwordConfirmTEC.dispose();
    _usernameTEC.dispose();
  }

  /// 프로필 이미지 선택하기
  _handleSelectProfileImage() async {
    _xFile = await ImageUtils.selectImageFromGallery();
    _imageData = await _xFile?.readAsBytes();
    setState(() {});
  }

  /// 프로필 이미지 취소하기
  _handleClearImage() => setState(() {
        _xFile = null;
        _imageData = null;
      });

  /// 회원가입 처리
  _signUpWithEmailAndPassword() {
    if (_xFile == null) return;
    ref.read(authControllerProvider).signUpWithEmailAndPassword(
          context: context,
          formKey: _formKey,
          emailTEC: _emailTEC,
          passwordTEC: _passwordTEC,
          usernameTEC: _usernameTEC,
          passwordConfirmTEC: _passwordConfirmTEC,
          xFile: _xFile!,
        );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      leading: InkWell(
        onTap: () {
          context.go('/login');
        },
        child: const Icon(Icons.arrow_back_ios),
      ),
      title: Text(
        "Sign Up",
        style: GoogleFonts.lobsterTwo(
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
      ),
    );
  }

  Widget _header({required String label, required IconData iconData}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Width(10),
          Icon(
            iconData,
            size: 30,
          ),
          const Width(10),
          Text(
            label,
            style:
                GoogleFonts.lobster(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Form _accountForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextFormField(
                controller: _emailTEC,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "press email address",
                  border: OutlineInputBorder(),
                  labelText: "Email",
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                ),
                validator: (v) =>
                    (v == null || v.isEmpty) ? "Press Email" : null),
            const Height(32),
            TextFormField(
              controller: _passwordTEC,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: "press password",
                border: OutlineInputBorder(),
                labelText: "Password",
                prefixIcon: Icon(
                  Icons.key,
                ),
              ),
              validator: (v) =>
                  (v == null || v.isEmpty) ? "Press Password" : null,
            ),
            const Height(32),
            TextFormField(
              controller: _passwordConfirmTEC,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: "press password again",
                border: OutlineInputBorder(),
                labelText: "Password Confirm",
                prefixIcon: Icon(
                  Icons.key,
                ),
              ),
              validator: (v) =>
                  (v != _passwordTEC.text) ? "password is not matched" : null,
            ),
            const Height(32),
            TextFormField(
              controller: _usernameTEC,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: "your nickname on app",
                border: OutlineInputBorder(),
                labelText: "Username",
                prefixIcon: Icon(
                  Icons.abc,
                ),
              ),
              validator: (v) =>
                  (v == null || v.isEmpty) ? "Press username" : null,
            )
          ],
        ),
      ),
    );
  }

  Widget _profileImage() => Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(300),
        ),
        child: _imageData == null
            ? Center(
                child: IconButton(
                  onPressed: () {
                    _handleSelectProfileImage();
                  },
                  icon: const Icon(
                    Icons.add_a_photo_outlined,
                    size: 50,
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Positioned(
                      child: Center(
                        child: Image.memory(
                          _imageData!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: _handleClearImage,
                        icon: const Icon(
                          Icons.dangerous,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Height(30),
              _header(label: "Account", iconData: Icons.account_circle),
              const Height(5),
              _accountForm(),
              const Height(20),
              const Divider(),
              _header(label: "Photo", iconData: Icons.photo),
              _profileImage(),
              const Height(100),
            ],
          ),
        ),
        floatingActionButton: (_imageData != null &&
                _emailTEC.text.isNotEmpty &&
                _passwordTEC.text.isNotEmpty &&
                _usernameTEC.text.isNotEmpty)
            ? FloatingActionButton.extended(
                onPressed: _signUpWithEmailAndPassword,
                label: Text(
                  "Submit",
                  style: GoogleFonts.lobster(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
