import 'dart:io';

import 'package:hot_place/core/constant/supbase.constant.dart';
import 'package:hot_place/core/error/custom_exception.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/data_source/user/user.data_source.dart';
import 'package:hot_place/domain/model/user/user.model.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/util/image.util.dart';

class RemoteUserDataSource extends UserDataSource {
  final GoTrueClient _auth;
  final PostgrestClient _db;
  final SupabaseStorageClient _storage;

  RemoteUserDataSource(
      {required GoTrueClient auth,
      required PostgrestClient db,
      required SupabaseStorageClient storage})
      : _auth = auth,
        _db = db,
        _storage = storage;

  final _logger = Logger();

  @override
  Future<UserModel> findUserById(String uid) async {
    try {
      return await _db
          .from(TableName.user.name)
          .select('*')
          .eq('id', uid)
          .limit(1)
          .then((fetched) => fetched.first)
          .then((json) => UserModel.fromJson(json));
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError,
          message: 'fail to find user with id: $uid');
    }
  }

  @override
  Future<void> modifyUser(UserModel user) async {
    try {
      await _db.from(TableName.user.name).update(user.toJson()).eq('id', user.id);
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError, message: 'modify user fails');
    }
  }

  @override
  Future<String> upsertProfileImageAndReturnDownloadLink(File image) async {
    try {
      final currentUid = _auth.currentUser!.id;
      final compressedImage = await ImageUtil.compressImage(image);
      final path = '$currentUid/profile-image.jpg';
      await _storage.from(BucketName.user.name).upload(path, compressedImage,
          fileOptions: const FileOptions(
            cacheControl: '3600',
            upsert: true,
          ));
      return _storage.from(BucketName.user.name).getPublicUrl(path);
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.storageError,
          message: 'error occurs on uploading profile image');
    }
  }
}
