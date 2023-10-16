import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/controller/register.controller.dart';
import 'package:my_app/presentation/components/custom_text_field.widget.dart';
import 'package:my_app/presentation/components/loading_container.widget.dart';
import 'package:my_app/presentation/features/auth/profile_image.widget.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) => Obx(
        () => SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "회원가입",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: LoadingContainer(
              isLoading: controller.isLoading,
              child: SingleChildScrollView(
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
                        textInputType: TextInputType.emailAddress,
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
                        hintText: "1q2w3e4r!",
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
                        hintText: "Karma",
                        prefixIconData: Icons.person_outline,
                      ),
                      const SizedBox(height: 10),
                      const Divider(thickness: 0.2),
                      const SizedBox(height: 10),

                      // 나이
                      CustomTextFieldWidget(
                        textInputType: TextInputType.number,
                        tec: controller.ageTEC,
                        labelText: "나이",
                        prefixIconData: Icons.onetwothree_outlined,
                      ),
                      const SizedBox(height: 10),
                      const Divider(thickness: 0.2),
                      const SizedBox(height: 10),

                      // 전화번호
                      CustomTextFieldWidget(
                        textInputType: TextInputType.phone,
                        tec: controller.phoneTEC,
                        labelText: "전화번호",
                        hintText: "010-1234-1234",
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

                      // 이상형
                      CustomTextFieldWidget(
                        tec: controller.idealTEC,
                        labelText: "이상형",
                        hintText: "귀여운 스타일",
                        prefixIconData: Icons.face_2_outlined,
                      ),
                      const SizedBox(height: 10),
                      const Divider(thickness: 0.2),
                      const SizedBox(height: 10),

                      // 키
                      CustomTextFieldWidget(
                        textInputType: TextInputType.number,
                        tec: controller.heightTEC,
                        labelText: "키",
                        prefixIconData: Icons.height_outlined,
                      ),
                      const SizedBox(height: 10),
                      const Divider(thickness: 0.2),
                      const SizedBox(height: 10),

                      // 직업
                      CustomTextFieldWidget(
                        tec: controller.jobTEC,
                        labelText: "직업",
                        prefixIconData: Icons.money_outlined,
                      ),
                      const SizedBox(height: 10),
                      const Divider(thickness: 0.2),
                      const SizedBox(height: 10),

                      // 자기소개
                      CustomTextFieldWidget(
                        tec: controller.introduceTEC,
                        labelText: "한 줄 자기소개",
                        hintText: "안녕~! 나는 민이라고 해",
                        prefixIconData: Icons.text_fields_outlined,
                      ),
                      const SizedBox(height: 20),

                      // 회원가입 버튼
                      InkWell(
                        onTap: controller.createAccountWithEmailAndPassword,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                            child: Text(
                              "회원가입",
                              style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
