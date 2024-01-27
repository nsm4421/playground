import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:multi_image_picker/src/asset.dart';
import 'package:my_app/api/user/user.api.dart';
import 'package:my_app/core/constant/notification.eum.dart';

import 'package:my_app/core/util/image.util.dart';
import 'package:my_app/domain/dto/notification/notification.dto.dart';
import 'package:my_app/domain/dto/user/user.dto.dart';
import 'package:my_app/domain/model/user/user.model.dart';

import '../../api/notification/notification.api.dart';
import '../../core/response/response.dart';
import 'user.repository.dart';

@Singleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final UserApi _userApi;
  final NotificationApi _notificationApi;

  UserRepositoryImpl(
      {required UserApi userApi, required NotificationApi notificationApi})
      : _userApi = userApi,
        _notificationApi = notificationApi;

  @override
  String? get currentUid => _userApi.currentUid;

  @override
  Future<Response<UserModel?>> getCurrentUser() async {
    try {
      final currentUser = (await _userApi.getCurrentUser())?.toModel();
      return Response<UserModel?>(
          status: currentUser != null ? Status.success : Status.error,
          data: currentUser);
    } catch (err) {
      return Response<UserModel>(status: Status.error, message: err.toString());
    }
  }

  @override
  Future<void> signOut() async => await _userApi.signOut();

  @override
  Future<Response<void>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _userApi.signInWithEmailAndPassword(
          email: email, password: password);
      return const Response<void>(
          status: Status.success, message: 'login success');
    } catch (err) {
      return Response<void>(status: Status.error, message: err.toString());
    }
  }

  @override
  Future<Response<UserCredential>> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await _userApi.createUserWithEmailAndPassword(
          email: email, password: password);
      return Response<UserCredential>(status: Status.success, data: credential);
    } catch (err) {
      return Response<UserCredential>(
          status: Status.error, message: err.toString());
    }
  }

  @override
  Future<Response<void>> saveUser(
      {required String uid,
      required String email,
      required String nickname}) async {
    try {
      await _userApi
          .saveUser(UserDto(uid: uid, email: email, nickname: nickname));
      return const Response<void>(status: Status.success);
    } catch (err) {
      return Response<void>(status: Status.error, message: err.toString());
    }
  }

  @override
  Future<Response<void>> updateProfile(
      {required String nickname, required List<Asset> assets}) async {
    try {
      // get current user
      final currentUser = await _userApi.getCurrentUser();
      if (currentUser == null) {
        throw const CertificateException('to update profile, need to login');
      }
      // save profile image
      final profileImageUrls = assets.isEmpty
          ? currentUser.profileImageUrls
          : await _userApi.saveProfileImages(
              uid: currentUser.uid,
              imageDataList: await ImageUtil.getImageData(assets));
      // update user info
      await _userApi.saveUser(currentUser.copyWith(
          nickname: nickname, profileImageUrls: profileImageUrls));
      return const Response<void>(status: Status.success);
    } catch (err) {
      return Response<void>(status: Status.error, message: err.toString());
    }
  }

  @override
  Future<Response<List<UserModel>>> findUserByNickname(String nickname) async {
    try {
      return Response<List<UserModel>>(
          status: Status.success,
          data: (await _userApi.findUserByNickname(nickname))
              .map((e) => e.toModel())
              .toList());
    } catch (err) {
      debugPrint(err.toString());
      return Response<List<UserModel>>(
          status: Status.error, message: err.toString());
    }
  }

  @override
  Future<Response<void>> followUser(String opponentUid) async {
    try {
      await _userApi.followUser(opponentUid);
      final nickname = (await _userApi.getCurrentUser())?.nickname;
      await _notificationApi.createNotification(NotificationDto(
          title: 'Got Follower',
          message: '${nickname ?? 'somebody'} follow you',
          type: NotificationType.follow,
          receiverUid: opponentUid,
          createdAt: DateTime.now()));
      return const Response<void>(status: Status.success);
    } catch (err) {
      debugPrint(err.toString());
      return Response<void>(status: Status.error, message: err.toString());
    }
  }

  @override
  Future<Response<void>> unFollowUser(String opponentUid) async {
    try {
      await _userApi.unFollowUser(opponentUid);
      return const Response<void>(status: Status.success);
    } catch (err) {
      debugPrint(err.toString());
      return Response<void>(status: Status.error, message: err.toString());
    }
  }
}
