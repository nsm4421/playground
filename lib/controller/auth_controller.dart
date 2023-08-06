import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_sns/model/user_dto.dart';
import 'package:flutter_sns/repository/user_repository.dart';
import 'package:flutter_sns/util/init_binding.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  Rx<UserDto> user = UserDto().obs;

  static AuthController get to => Get.find();

  Future<UserDto?> loginUser(String uid) async {
    UserDto? userDto = await UserRepository.findByUid(uid);
    if (userDto != null) {
      InitBinding.additionalBinding();
      user(userDto);
    };
    return userDto;
  }

  Future<bool> signUp({required UserDto dto, XFile? xFile}) async {
    UserDto dtoForUpload = dto.copyWith();
    // uid가 없는 경우 → 오류
    if (dtoForUpload.uid == null) return false;
    // Thumbnail이 있는 경우 → thumbnail 필드 업데이트
    if (xFile != null) {
      final filename = '${dto.uid}/profile.${xFile.path.split(".").last}';
      UserRepository.uploadThumbnail(xFile: xFile, filename: filename)
          ?.snapshotEvents
          .listen((event) async {
        final bool isSuccessThumbnailUpload =
            (event.bytesTransferred == event.totalBytes) &&
                (event.state == TaskState.success);
        if (isSuccessThumbnailUpload) {
          dtoForUpload = dtoForUpload.copyWith(
              thumbnail: await event.ref.getDownloadURL());
        }
      });
    }
    // DB에 유저정보 저장
    final bool isSuccessSignUp = await UserRepository.signUp(dtoForUpload);
    // SignIn 성공시 state(user) 업데이트
    if (isSuccessSignUp) user(dtoForUpload);
    // 성공여부 반환
    return isSuccessSignUp;
  }
}
