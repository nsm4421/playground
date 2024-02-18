import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hot_place/features/app/constant/firebase.constant.dart';
import 'package:hot_place/features/user/data/data_source/user.remote_data_source.dart';
import 'package:hot_place/features/user/data/model/user/user.model.dart';

import 'package:hot_place/features/user/domain/entity/contact/contact.entity.dart';
import 'package:hot_place/features/user/domain/entity/user/user.entity.dart';
import 'package:logger/logger.dart';

import '../../../app/util/uuid.util.dart';

class RemoteUserDataSourceImpl extends RemoteUserDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _fireStore;

  RemoteUserDataSourceImpl(
      {required FirebaseAuth auth, required FirebaseFirestore fireStore})
      : _auth = auth,
        _fireStore = fireStore;

  String _verificationId = "";
  static const _verificationDuration = 180;

  final _logger = Logger();

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async =>
      // TODO : 인증실패 처리
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (AuthCredential authCredential) {
            _logger.d("인증완료");
          },
          verificationFailed: (FirebaseAuthException firebaseAuthException) {
            _logger.w("인증 실패");
          },
          timeout: const Duration(seconds: _verificationDuration),
          codeSent: (String verificationId, int? forceResendingToken) {
            _logger.d("인증코드 보냄");
            _verificationId = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            _verificationId = verificationId;
            _logger.w("시간초과");
          });

  @override
  Future<void> verifyOtpNumber(String otpCode) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          smsCode: otpCode, verificationId: _verificationId);
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-verification-code') {
        _logger.e("인증코드 오류", err);
      } else if (err.code == 'quota-exceeded') {
        _logger.e("쿼터 초과", err);
      }
    } catch (err) {
      _logger.e(err);
    }
  }

  @override
  bool get isAuthorized => (_auth.currentUser?.uid != null);

  @override
  String? get currentUid => _auth.currentUser?.uid;

  @override
  Future<void> signOut() async => await _auth.signOut();

  @override
  Future<void> insertUser(UserEntity user) async {
    final uid = UuidUtil.uuid();
    final json = user.toModel().copyWith(uid: uid).toJson();
    try {
      await _fireStore.collection(CollectionName.user).doc(uid).set(json);
    } catch (err) {
      _logger.e(err);
      throw Exception("유저 데이터 넣는 중 오류 발생");
    }
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    try {
      if (user.uid == null) {
        throw Exception("유저 id가 주어지지 않음");
      }
      final json = user.toModel().toJson();
      await _fireStore.collection(CollectionName.user).doc(user.uid).set(json);
    } catch (err) {
      _logger.e(err);
      throw Exception("유저 수정 중 오류 발생");
    }
  }

  @override
  Stream<List<UserEntity>> get allUserStream => _fireStore
      .collection(CollectionName.user)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((e) => e.data())
          .map((json) => UserModel.fromJson(json))
          .map((model) => model.toEntity())
          .toList());

  @override
  Stream<UserEntity> getUserStream(String uid) => _fireStore
      .collection(CollectionName.user)
      .doc(uid)
      .snapshots()
      .asyncMap((e) => UserModel.fromJson(e.data() ?? {}).toEntity());

  @override
  Future<List<ContactEntity>> getDeviceNumber() {
    // TODO: implement getDeviceNumber
    throw UnimplementedError();
  }
}
