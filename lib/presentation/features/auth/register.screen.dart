import 'package:flutter/material.dart';

import '../../components/custom_text_field.widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // 개인정보
  late TextEditingController _emailTEC;
  late TextEditingController _passwordTEC;
  late TextEditingController _nicknameTEC;
  late TextEditingController _ageTEC;
  late TextEditingController _phoneTEC;
  late TextEditingController _cityTEC;
  late TextEditingController _introduceTEC; // 한줄 자기소개
  late TextEditingController _heightTEC; // 키
  late TextEditingController _jobTEC; // 직업
  late TextEditingController _relationLookingForTEC; // 관계

  @override
  void initState() {
    super.initState();
    _emailTEC = TextEditingController();
    _passwordTEC = TextEditingController();
    _nicknameTEC = TextEditingController();
    _ageTEC = TextEditingController();
    _phoneTEC = TextEditingController();
    _cityTEC = TextEditingController();
    _heightTEC = TextEditingController();
    _introduceTEC = TextEditingController();
    _jobTEC = TextEditingController();
    _relationLookingForTEC = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEC.dispose();
    _passwordTEC.dispose();
    _nicknameTEC.dispose();
    _ageTEC.dispose();
    _phoneTEC.dispose();
    _cityTEC.dispose();
    _introduceTEC.dispose();
    _heightTEC.dispose();
    _jobTEC.dispose();
    _relationLookingForTEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "회원가입",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),

                // 이메일
                CustomTextFieldWidget(
                  tec: _emailTEC,
                  labelText: "이메일",
                  prefixIconData: Icons.email_outlined,
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 0.2),
                const SizedBox(height: 10),

                // 비밀번호
                CustomTextFieldWidget(
                  tec: _passwordTEC,
                  labelText: "비밀번호",
                  prefixIconData: Icons.lock_outline,
                  isObscure: true,
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 0.2),
                const SizedBox(height: 10),

                // 닉네임
                CustomTextFieldWidget(
                  tec: _nicknameTEC,
                  labelText: "닉네임",
                  prefixIconData: Icons.person_outline,
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 0.2),
                const SizedBox(height: 10),

                // 나이
                CustomTextFieldWidget(
                  tec: _ageTEC,
                  labelText: "나이",
                  prefixIconData: Icons.onetwothree_outlined,
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 0.2),
                const SizedBox(height: 10),

                // 전화번호
                CustomTextFieldWidget(
                  tec: _phoneTEC,
                  labelText: "전화번호",
                  prefixIconData: Icons.phone_android_outlined,
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 0.2),
                const SizedBox(height: 10),

                // 도시
                CustomTextFieldWidget(
                  tec: _cityTEC,
                  labelText: "도시",
                  prefixIconData: Icons.location_city_outlined,
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 0.2),
                const SizedBox(height: 10),

                // 한줄 자기소개
                CustomTextFieldWidget(
                  tec: _introduceTEC,
                  labelText: "자기소개",
                  prefixIconData: Icons.text_fields_outlined,
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 0.2),
                const SizedBox(height: 10),

                // 키
                CustomTextFieldWidget(
                  tec: _heightTEC,
                  labelText: "키",
                  prefixIconData: Icons.height_outlined,
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 0.2),
                const SizedBox(height: 10),

                // 직업
                CustomTextFieldWidget(
                  tec: _relationLookingForTEC,
                  labelText: "직업",
                  prefixIconData: Icons.money_outlined,
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 0.2),
                const SizedBox(height: 10),

                // 이상형
                CustomTextFieldWidget(
                  tec: _relationLookingForTEC,
                  labelText: "이상형",
                  prefixIconData: Icons.face_2_outlined,
                  maxLength: 200,
                  height: 300,
                  maxLine: null,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // TODO : 회원가입 기능구현하기
          onPressed: () {},
          child: const Icon(
            Icons.keyboard_arrow_right_rounded,
            size: 30,
          ),
        ),
      ),
    );
  }
}
