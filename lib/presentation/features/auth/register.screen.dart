import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/controller/register.controller.dart';
import 'package:my_app/presentation/components/custom_text_field.widget.dart';
import 'package:my_app/presentation/features/auth/profile_image.widget.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
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

                  // 프로필 이미지
                  const Center(child: ProfileImageWidget()),
                  const SizedBox(height: 30),

                  // 이메일
                  CustomTextFieldWidget(
                    tec: controller.emailTEC,
                    labelText: "이메일",
                    prefixIconData: Icons.email_outlined,
                  ),
                  const SizedBox(height: 10),
                  const Divider(thickness: 0.2),
                  const SizedBox(height: 10),

                  // 비밀번호
                  CustomTextFieldWidget(
                    tec: controller.passwordTEC,
                    labelText: "비밀번호",
                    prefixIconData: Icons.lock_outline,
                    isObscure: true,
                  ),
                  const SizedBox(height: 10),
                  const Divider(thickness: 0.2),
                  const SizedBox(height: 10),

                  // 닉네임
                  CustomTextFieldWidget(
                    tec: controller.nicknameTEC,
                    labelText: "닉네임",
                    prefixIconData: Icons.person_outline,
                  ),
                  const SizedBox(height: 10),
                  const Divider(thickness: 0.2),
                  const SizedBox(height: 10),

                  // 나이
                  CustomTextFieldWidget(
                    tec: controller.ageTEC,
                    labelText: "나이",
                    prefixIconData: Icons.onetwothree_outlined,
                  ),
                  const SizedBox(height: 10),
                  const Divider(thickness: 0.2),
                  const SizedBox(height: 10),

                  // 전화번호
                  CustomTextFieldWidget(
                    tec: controller.phoneTEC,
                    labelText: "전화번호",
                    prefixIconData: Icons.phone_android_outlined,
                  ),
                  const SizedBox(height: 10),
                  const Divider(thickness: 0.2),
                  const SizedBox(height: 10),

                  // 도시
                  CustomTextFieldWidget(
                    tec: controller.cityTEC,
                    labelText: "도시",
                    prefixIconData: Icons.location_city_outlined,
                  ),
                  const SizedBox(height: 10),
                  const Divider(thickness: 0.2),
                  const SizedBox(height: 10),

                  // 한줄 자기소개
                  CustomTextFieldWidget(
                    tec: controller.introduceTEC,
                    labelText: "자기소개",
                    prefixIconData: Icons.text_fields_outlined,
                  ),
                  const SizedBox(height: 10),
                  const Divider(thickness: 0.2),
                  const SizedBox(height: 10),

                  // 키
                  CustomTextFieldWidget(
                    tec: controller.heightTEC,
                    labelText: "키",
                    prefixIconData: Icons.height_outlined,
                  ),
                  const SizedBox(height: 10),
                  const Divider(thickness: 0.2),
                  const SizedBox(height: 10),

                  // 직업
                  CustomTextFieldWidget(
                    tec: controller.idealTEC,
                    labelText: "직업",
                    prefixIconData: Icons.money_outlined,
                  ),
                  const SizedBox(height: 10),
                  const Divider(thickness: 0.2),
                  const SizedBox(height: 10),

                  // 이상형
                  CustomTextFieldWidget(
                    tec: controller.idealTEC,
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
