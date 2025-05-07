import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:injectable/injectable.dart';
import 'package:multi_image_picker/src/asset.dart';
import 'package:my_app/data/data_source/remote/auth/auth.api.dart';
import 'package:my_app/data/mapper/user_mapper.dart';
import 'package:my_app/domain/model/user/user.model.dart';

import '../../core/constant/enums/status.enum.dart';
import '../../core/utils/response_wrappper/response_wrapper.dart';
import '../../domain/repository/auth.repository.dart';

@Singleton(as: AuthRepository) // 의존성 주입
class AuthRepositoryImpl extends AuthRepository {
  final AuthApi _authApi;

  static const int _quality = 96; // 프로필 이미지 압축 시, 이미지 품질

  AuthRepositoryImpl(this._authApi);

  /// 이메일로 유저 조회
  @override
  Future<ResponseWrapper<UserModel?>> findByEmail(String email) async {
    try {
      final user = (await _authApi.findByEmail(email))?.toModel();
      return ResponseWrapper<UserModel>(
          status: ResponseStatus.success, data: user);
    } catch (err) {
      return const ResponseWrapper<UserModel>(status: ResponseStatus.error);
    }
  }

  /// 현재 로그인한 유저 정보 가져오기
  @override
  Future<ResponseWrapper<UserModel?>> getCurrentUserInfo() async {
    try {
      final email = _authApi.currentUser?.email;
      if (email == null) {
        return const ResponseWrapper<UserModel>(
            status: ResponseStatus.error, message: "NOT LOGIN");
      }
      return findByEmail(email);
    } catch (err) {
      return const ResponseWrapper<UserModel>(status: ResponseStatus.error);
    }
  }

  /// 구글 계정으로 로그인
  @override
  Future<ResponseWrapper<UserCredential>> signInWithGoogle() async {
    try {
      final credential = await _authApi.signInWithGoogle();
      return ResponseWrapper<UserCredential>(
          status: ResponseStatus.success, data: credential);
    } catch (err) {
      return const ResponseWrapper<UserCredential>(
          status: ResponseStatus.error);
    }
  }

  /// 닉네임 중복여부
  @override
  Future<bool> checkNicknameDuplicated(String nickname) async =>
      await _authApi.checkNicknameDuplicated(nickname);

  /// 유저 정보 업로드
  @override
  Future<ResponseWrapper<void>> submitOnBoardingForm(
      {required String uid,
      required UserModel user,
      required List<Asset> images}) async {
    try {
      // 닉네임 검사
      if (user.nickname == null) {
        return const ResponseWrapper<void>(
            status: ResponseStatus.error, message: "NICKNAME IS NULL");
      }
      if (await _authApi.checkNicknameDuplicated(user.nickname!)) {
        return const ResponseWrapper<void>(
            status: ResponseStatus.error, message: "USERNAME IS DUPLICATED");
      }
      // 프로필 이미지 저장 후, 다운로드 링크 얻기
      List<String> profileImageUrls = [];
      for (final image in images) {
        Uint8List compressedImageData = await image
            .getByteData()
            .then((byte) => byte.buffer.asUint8List())
            .then((data) =>
                FlutterImageCompress.compressWithList(data, quality: _quality));
        final filename =
            '${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
        final downloadUrl = await _authApi.saveProfileImage(
            uid: uid, filename: filename, imageData: compressedImageData);
        profileImageUrls.add(downloadUrl);
      }
      // 유저 정보 DB에 저장
      await _authApi.saveUserInfoInDB(
          uid: uid,
          dto: user
              .copyWith(
                  profileImageUrls: profileImageUrls, createdAt: DateTime.now())
              .toDto());
      return const ResponseWrapper<void>(status: ResponseStatus.success);
    } catch (err) {
      return const ResponseWrapper<void>(
          status: ResponseStatus.error, message: "SERVER ERROR");
    }
  }
}
