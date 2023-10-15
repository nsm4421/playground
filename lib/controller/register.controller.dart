import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
    _jobTEC = TextEditingController();
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
}
