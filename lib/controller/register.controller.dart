import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/core/util/logger.dart';
import 'package:my_app/model/user/user.model.dart';
import 'package:my_app/repository/auth.repository.dart';

class RegisterController extends GetxController {
  static RegisterController get to => Get.find();

  static Future<bool> get del => Get.delete<RegisterController>();

  late TextEditingController _emailTEC;
  late TextEditingController _passwordTEC;
  late TextEditingController _nicknameTEC;
  late TextEditingController _ageTEC;
  late TextEditingController _phoneTEC;
  late TextEditingController _cityTEC;
  late TextEditingController _introduceTEC; // 한줄 자기소개
  late TextEditingController _heightTEC; // 키
  late TextEditingController _jobTEC; // 직업
  late TextEditingController _idealTEC; // 이상형
  final Rx<File?> _profileImage = Rx<File?>(null); // 프로필 이미지
  XFile? _pickedImage; // image picker로 선택한 이미지
  final RxBool _isLoading = false.obs;

  // getter
  TextEditingController get emailTEC => _emailTEC;

  TextEditingController get passwordTEC => _passwordTEC;

  TextEditingController get nicknameTEC => _nicknameTEC;

  TextEditingController get ageTEC => _ageTEC;

  TextEditingController get phoneTEC => _phoneTEC;

  TextEditingController get cityTEC => _cityTEC;

  TextEditingController get introduceTEC => _introduceTEC;

  TextEditingController get heightTEC => _heightTEC;

  TextEditingController get jobTEC => _jobTEC;

  TextEditingController get idealTEC => _idealTEC;

  Rx<File?> get profileImage => _profileImage;

  bool get isLoading => _isLoading.value;

  @override
  onInit() {
    super.onInit();
    _emailTEC = TextEditingController();
    _passwordTEC = TextEditingController();
    _nicknameTEC = TextEditingController();
    _ageTEC = TextEditingController();
    _phoneTEC = TextEditingController();
    _cityTEC = TextEditingController();
    _introduceTEC = TextEditingController();
    _heightTEC = TextEditingController();
    _jobTEC = TextEditingController();
    _idealTEC = TextEditingController();
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
    _idealTEC.dispose();
  }

  /// 프로필 이미지 (갤러리/카메라)에서 선택하기
  pickImageFileFromGallery({bool fromGallery = true}) async {
    _pickedImage = await ImagePicker().pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera);
    if (_pickedImage == null) {
      Get.snackbar("Error", "프로필 이미지를 선택 중 에러가 발생했습니다");
      return;
    }
    _profileImage.value = File(_pickedImage!.path);
  }

  /// 프로필 이미지 취소하기
  cancelProfileImage() {
    _profileImage.value = null;
  }

  /// 이메일, 비밀번호로 회원가입하기
  createAccountWithEmailAndPassword() async {
    try {
      _isLoading.value = true;

      // 입력값 검사
      final email = _emailTEC.value.text;
      final password = _passwordTEC.value.text;
      final nickname = _nicknameTEC.value.text;
      final age = _ageTEC.value.text;
      final phone = _phoneTEC.value.text;
      final city = _cityTEC.value.text;
      final introduce = _introduceTEC.value.text;
      final height = _heightTEC.value.text;
      final job = _jobTEC.value.text;
      final ideal = _idealTEC.value.text;
      final profileImage = _profileImage.value;

      if (!email.isEmail) {
        Get.snackbar('ERROR', '이메일을 입력해주세요');
        return;
      }
      if (password.isEmpty) {
        Get.snackbar('ERROR', '비밀번호를 입력해주세요');
        return;
      }
      if (nickname.isEmpty) {
        Get.snackbar('ERROR', '닉네임을 입력해주세요');
        return;
      }
      if (profileImage == null) {
        Get.snackbar('ERROR', '프로필 이미지를 등록해주세요');
        return;
      }

      // 닉네임 중복여부 검사
      final isDuplicatedNickname =
          await AuthRepository.to.isDuplicated("nickname", nickname);
      if (isDuplicatedNickname) {
        Get.snackbar('ERROR', '중복된 닉네임입니다');
        return;
      }

      // 회원가입
      final credential = await AuthRepository.to
          .createAccountWithEmailAndPassword(email: email, password: password);
      if (credential?.user?.uid == null) {
        Get.snackbar('ERROR', '회원가입 중 오류가 발생하였습니다');
        return;
      }
      final uid = credential!.user!.uid;

      // 프로필 이미지 저장
      final profileImageUrl = await AuthRepository.to
          .saveProfileImageInStorage(uid: uid, profileImage: profileImage);
      if (profileImageUrl == null) {
        Get.snackbar('WARNING', '프로필 이미지 등록에 실패했습니다');
      }

      // TODO : 비밀번호 암호화
      final user = UserModel(
          email: email,
          nickname: nickname,
          password: password,
          age: int.parse(age),
          phone: phone,
          city: city,
          introduce: introduce,
          height: int.parse(height),
          job: job,
          ideal: ideal,
          profileImageUrl: profileImageUrl,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now());
      await AuthRepository.to
          .saveDataInUserCollection(uid: uid, data: user.toJson());

      // 성공 시 로그인 페이지로 이동
      Get.snackbar('SUCCESS', '회원가입에 성공하였습니다');
      Get.toNamed('/login');
    } catch (e) {
      CustomLogger.logger.e(e);
      Get.snackbar('ERROR', e.toString());
    } finally {
      _isLoading.value = false;
    }
  }
}
