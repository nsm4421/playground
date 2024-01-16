import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/enums/response_status.enum.dart';
import 'package:my_app/core/response/response_wrapper.dart';
import 'package:my_app/data/data_source/base/rest.api.dart';
import 'package:my_app/data/data_source/base/storage.api.dart';
import 'package:my_app/data/dto/auth/user/user.dto.dart';
import 'package:my_app/domain/model/auth/user.model.dart';
import 'package:my_app/domain/repository/user/user.repository.dart';

import '../../../core/enums/supabase.enum.dart';
import '../../data_source/base/auth.api.dart';

@Singleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final AuthApi _authApi;
  final RestApi _restApi;
  final StorageApi _storageApi;

  UserRepositoryImpl(
      {required AuthApi authApi,
      required RestApi restApi,
      required StorageApi storageApi})
      : _authApi = authApi,
        _restApi = restApi,
        _storageApi = storageApi;

  @override
  Stream<UserModel> currentUserStream() {
    final currentUid = _authApi.currentUid;
    if (currentUid == null) throw Exception('NOT_LOGIN');
    return userStreamById(currentUid);
  }

  @override
  Stream<UserModel> userStreamById(String userId) => _restApi
      .userStreamById(userId)
      .map((event) => UserModel.fromJson(event[0]));

  @override
  Future<ResponseWrapper<UserModel>> getCurrentUser() async {
    final currentUid = _authApi.currentUid;
    return currentUid == null
        ? const ResponseWrapper<UserModel>(
            status: ResponseStatus.error, message: 'NOT_LOGIN')
        : await findUserById(currentUid);
  }

  /// id로 유저 조회
  @override
  Future<ResponseWrapper<UserModel>> findUserById(String userId) async {
    try {
      return ResponseWrapper<UserModel>(
          status: ResponseStatus.success,
          data: (await _restApi.findUserById(userId)).dtoToModel());
    } catch (err) {
      return ResponseWrapper<UserModel>(
          status: ResponseStatus.error, message: err.toString());
    }
  }

  /// 프로필(닉네임, 프사) 수정
  @override
  Future<ResponseWrapper<UserModel>> editProfile(
      {String? nickname, XFile? profileImageData}) async {
    try {
      // 현재 로그인한 유저를 가져온다
      final user = UserDto.fromAuth(_authApi.currentUser).dtoToModel();
      final uid = _authApi.currentUid;
      if (uid == null) throw Exception('NOT_LOGIN');

      // 이미지를 업데이트가 필요한 경우 Storage에 저장 후 다운로드 링크를 가져온다
      final profileImage = profileImageData == null
          ? user.profileImage
          : await _storageApi.uploadFile(
              file: File(profileImageData.path),
              bucketName: BucketName.profileImage,
              dir: uid,
              filename: 'profile-image.jpg',
              upsert: true);

      // 유저정보를 DB에 저장한다
      await _restApi.updateUser(
          uid: uid, nickname: nickname, profileImage: profileImage);

      // 메타데이터를 업데이트한다
      await _authApi.updateUserMetaData({
        if (nickname != null) 'nickname': nickname,
        if (profileImage != null) 'profileImage': profileImage
      });

      // 저장한 정보를 return
      return ResponseWrapper<UserModel>(
          status: ResponseStatus.success,
          data: user.copyWith(
              nickname: nickname ?? user.nickname,
              profileImage: profileImage ?? user.profileImage));
    } catch (err) {
      debugPrint(err.toString());
      return ResponseWrapper<UserModel>(
          status: ResponseStatus.error, message: err.toString());
    }
  }
}
