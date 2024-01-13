import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/enums/response_status.enum.dart';
import 'package:my_app/core/response/response_wrapper.dart';
import 'package:my_app/data/dto/auth/user/user.dto.dart';
import 'package:my_app/data/dto/auth/user/user_metadata.dto.dart';
import 'package:my_app/domain/model/auth/user_metadata.model.dart';
import 'package:my_app/domain/repository/auth/auth.repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/enums/bucket_name.enum.dart';
import '../../data_source/base/auth.api.dart';
import '../../data_source/base/storage.api.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthApi _authApi;
  final StorageApi _storageApi;

  AuthRepositoryImpl({required AuthApi authApi, required StorageApi storageApi})
      : _authApi = authApi,
        _storageApi = storageApi;

  @override
  User? getCurrentUer() => _authApi.getCurrentUer();

  @override
  Stream<User?> getCurrentUserStream() => _authApi.getCurrentUserStream();

  @override
  Future<void> signOut() => _authApi.signOut();

  @override
  Future<ResponseWrapper<void>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _authApi.signInWithEmailAndPassword(
          email: email, password: password);
      return const ResponseWrapper<void>(status: ResponseStatus.success);
    } catch (err) {
      return ResponseWrapper<void>(
          status: ResponseStatus.error, message: err.toString());
    }
  }

  @override
  Future<ResponseWrapper<void>> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      // sign up
      final user = await _authApi
          .signUpWithEmailAndPassword(email: email, password: password)
          .then((res) => res.user);
      if (user?.id == null) throw Exception('uid is null');

      // TODO : 유저 정보 DB에 저장

      return const ResponseWrapper<void>(status: ResponseStatus.success);
    } catch (err) {
      return ResponseWrapper<void>(
          status: ResponseStatus.error, message: err.toString());
    }
  }

  @override
  Future<ResponseWrapper<UserMetaDataModel>> editProfile(
      {required String nickname, XFile? profileImageData}) async {
    try {
      // get current user
      final user = _authApi.getCurrentUer();
      if (user == null) throw Exception('NOT_LOGIN');

      // if image data given, then save profile image
      final profileImage = profileImageData == null
          ? user.userToDto().metaData.profileImage
          : await _storageApi.uploadFile(
              file: File(profileImageData.path),
              bucketName: BucketName.profileImage,
              dir: user.id,
              filename: 'profile-image.jpg',
              upsert: true);

      // update meta data
      final metaData =
          UserMetaDataDto(nickname: nickname, profileImage: profileImage);
      await _authApi.updateMetaData(metaData);

      return ResponseWrapper<UserMetaDataModel>(
          status: ResponseStatus.success, data: metaData.dtoToModel());
    } catch (err) {
      return ResponseWrapper<UserMetaDataModel>(
          status: ResponseStatus.error, message: err.toString());
    }
  }
}
