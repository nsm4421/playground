import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_place/features/app/constant/firebase.constant.dart';
import 'package:hot_place/features/user/data/model/user/user.model.dart';

import 'package:hot_place/features/user/domain/entity/user/user.entity.dart';
import 'package:logger/logger.dart';

import '../../../app/util/uuid.util.dart';

class RemoteUserDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _fireStore;

  RemoteUserDataSource(
      {required FirebaseAuth auth, required FirebaseFirestore fireStore})
      : _auth = auth,
        _fireStore = fireStore;

  final _logger = Logger();

  bool get isAuthorized => (_auth.currentUser?.uid != null);

  String? get currentUid => _auth.currentUser?.uid;

  Future<void> signOut() async => await _auth.signOut();

  Future<void> insertUser(UserEntity user) async {
    final uid = UuidUtil.uuid();
    final json = user.toModel().copyWith(uid: uid).toJson();
    try {
      await _fireStore.collection(CollectionName.user.name).doc(uid).set(json);
    } catch (err) {
      _logger.e(err);
      throw Exception("유저 데이터 넣는 중 오류 발생");
    }
  }

  Future<void> updateUser(UserEntity user) async {
    try {
      if (user.uid == null) {
        throw Exception("유저 id가 주어지지 않음");
      }
      final json = user.toModel().toJson();
      await _fireStore
          .collection(CollectionName.user.name)
          .doc(user.uid)
          .set(json);
    } catch (err) {
      _logger.e(err);
      throw Exception("유저 수정 중 오류 발생");
    }
  }

  Stream<List<UserEntity>> get allUserStream => _fireStore
      .collection(CollectionName.user.name)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((e) => e.data())
          .map((json) => UserModel.fromJson(json))
          .map((model) => model.toEntity())
          .toList());

  Stream<UserEntity> getUserStream(String uid) => _fireStore
      .collection(CollectionName.user.name)
      .doc(uid)
      .snapshots()
      .asyncMap((e) => UserModel.fromJson(e.data() ?? {}).toEntity());
}
