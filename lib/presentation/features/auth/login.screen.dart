import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/presentation/components/custom_text_field.widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailTEC;
  late TextEditingController _passwordTEC;
  final bool _showProgressBar = false;

  @override
  void initState() {
    super.initState();
    _emailTEC = TextEditingController();
    _passwordTEC = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEC.dispose();
    _passwordTEC.dispose();
  }

  _goToRegisterPage() => Get.toNamed("/register");

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 30;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50),
                // TODO : 앱 로고로 넣기
                const Text(
                  "App Logo",
                  style: TextStyle(fontSize: 50),
                ),
                const SizedBox(height: 50),
                // 앱 이름
                const Text(
                  "Karma",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                const Text("데이트 앱 만들기",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 30),
                // 이메일
                CustomTextFieldWidget(
                  width: width,
                  tec: _emailTEC,
                  labelText: "이메일",
                  prefixIconData: Icons.email_outlined,
                ),
                const SizedBox(height: 20),
                // 비밀번호
                CustomTextFieldWidget(
                  width: width,
                  tec: _passwordTEC,
                  labelText: "비밀번호",
                  prefixIconData: Icons.lock_outline,
                  isObscure: true,
                ),
                const SizedBox(height: 20),
                // 로그인 버튼
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: width,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                // 회원가입 화면으로 이동하기
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "계정이 없으신가요?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                        onTap: _goToRegisterPage,
                        child: const Text("가입하기",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold))),
                  ],
                ),
                _showProgressBar
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.pinkAccent))
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
