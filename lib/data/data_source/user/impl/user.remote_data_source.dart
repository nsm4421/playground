import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hot_place/core/constant/firebase.constant.dart';
import 'package:hot_place/data/data_source/user/user.data_source.dart';
import 'package:hot_place/data/model/user/user.model.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';

import '../../../../core/util/uuid.util.dart';

class RemoteUserDataSource extends UserDataSource {
  final FirebaseFirestore _fireStore;

  RemoteUserDataSource({required FirebaseFirestore fireStore})
      : _fireStore = fireStore;

  @override
  Future<UserModel> findUserById(String uid) async => await _fireStore
      .collection(CollectionName.user.name)
      .doc(uid)
      .get()
      .then((snapshot) => snapshot.data())
      .then((json) => UserModel.fromJson(json ?? {}));

  @override
  Future<void> insertUser(UserModel user) async => await _fireStore
      .collection(CollectionName.user.name)
      .doc(user.uid)
      .set(user.toJson());

  @override
  Future<void> updateUser(UserModel user) async {
    if (user.uid.isEmpty) {
      throw Exception("유저 id가 주어지지 않음");
    }
    await _fireStore
        .collection(CollectionName.user.name)
        .doc(user.uid)
        .set(user.toJson());
  }

  @override
  Stream<List<UserEntity>> get allUserStream => _fireStore
      .collection(CollectionName.user.name)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((e) => e.data())
          .map((json) => UserModel.fromJson(json).toEntity())
          .toList());

  @override
  Stream<UserEntity> getUserStream(String uid) => _fireStore
      .collection(CollectionName.user.name)
      .doc(uid)
      .snapshots()
      .asyncMap((e) => UserModel.fromJson(e.data() ?? {}).toEntity());
}
