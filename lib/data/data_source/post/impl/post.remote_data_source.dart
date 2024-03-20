import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hot_place/core/constant/firebase.constant.dart';
import 'package:hot_place/core/util/uuid.util.dart';
import 'package:hot_place/data/data_source/post/post.data_source.dart';
import 'package:hot_place/data/model/post/like/like.model.dart';
import 'package:hot_place/data/model/post/post.model.dart';

class RemotePostDataSource extends PostDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _fireStore;
  final FirebaseStorage _storage;

  RemotePostDataSource(
      {required FirebaseAuth auth,
      required FirebaseFirestore fireStore,
      required FirebaseStorage storage})
      : _auth = auth,
        _fireStore = fireStore,
        _storage = storage;

  @override
  Future<String> createPost(PostModel post) async {
    final currentUid = _getCurrentUidOrElseThrow();
    final postId = post.id.isNotEmpty ? post.id : UuidUtil.uuid();
    await _fireStore.collection(CollectionName.post.name).doc(postId).set(post
        .copyWith(id: postId, authorUid: currentUid, createdAt: DateTime.now())
        .toJson());
    return postId;
  }

  @override
  Future<String> deletePostById(String postId) async {
    final post = await _fireStore
        .collection(CollectionName.post.name)
        .doc(postId)
        .get()
        .then((snapshot) => snapshot.data())
        .then((data) => PostModel.fromJson(data ?? {}));
    if (post.authorUid != _getCurrentUidOrElseThrow()) {
      throw Exception('author and login user are not same');
    }
    await _fireStore.collection(CollectionName.post.name).doc(postId).delete();
    return postId;
  }

  @override
  Future<PostModel> findPostById(String postId) async => await _fireStore
      .collection(CollectionName.post.name)
      .doc(postId)
      .get()
      .then((snapshot) => snapshot.data())
      .then((data) => PostModel.fromJson(data ?? {}));

  @override
  Future<String> modifyPost(PostModel post) async {
    final currentUid = _getCurrentUidOrElseThrow();
    final fetched = await _fireStore
        .collection(CollectionName.post.name)
        .doc(post.id)
        .get()
        .then((snapshot) => snapshot.data())
        .then((data) => PostModel.fromJson(data ?? {}));
    if (fetched.authorUid != _getCurrentUidOrElseThrow()) {
      throw Exception('author and login user are not same');
    }
    await _fireStore
        .collection(CollectionName.post.name)
        .doc(post.id)
        .set(post.copyWith(authorUid: currentUid).toJson());
    return post.id;
  }

  @override
  Future<String> uploadImage(File image) async {
    final ref = _storage.ref().child('images/${UuidUtil.uuid()}.png');
    await ref.putFile(image);
    return await ref.getDownloadURL();
  }

  @override
  Stream<List<PostModel>> getPostStream({int skip = 0, int take = 100}) =>
      _fireStore
          .collection(CollectionName.post.name)
          .snapshots()
          .skip(skip)
          .take(take)
          .asyncMap((snapshot) => snapshot.docs
              .map((doc) => PostModel.fromJson(doc.data()))
              .toList());

  @override
  Future<LikeModel?> getLike(String postId) async => await _fireStore
      .collection(CollectionName.post.name)
      .doc(postId)
      .collection(CollectionName.like.name)
      .where("uid", isEqualTo: _getCurrentUidOrElseThrow())
      .get()
      .then((snapshot) => snapshot.docs.isNotEmpty
          ? LikeModel.fromJson(snapshot.docs.first.data())
          : null);

  @override
  Future<String> likePost(String postId) async {
    // like 저장
    final likeId = UuidUtil.uuid();
    await _fireStore
        .collection(CollectionName.post.name)
        .doc(postId)
        .collection(CollectionName.like.name)
        .doc(likeId)
        .set(LikeModel(
                id: likeId,
                uid: _getCurrentUidOrElseThrow(),
                postId: postId,
                createdAt: DateTime.now())
            .toJson());
    // post에서 numLike필드 증가
    await _fireStore
        .collection(CollectionName.post.name)
        .doc(postId)
        .update({'numLike': FieldValue.increment(1)});
    return likeId;
  }

  @override
  Future<String> cancelLikePost(
      {required String postId, required String likeId}) async {
    // 좋아요 조회
    final fetched = await _fireStore
        .collection(CollectionName.post.name)
        .doc(postId)
        .collection(CollectionName.like.name)
        .doc(likeId)
        .get()
        .then((snapshot) => snapshot.data())
        .then((data) => LikeModel.fromJson(data ?? {}));
    // 좋아요 누른 유저와 로그인한 유저가 동일 유저인지 검사
    if (fetched.uid != _getCurrentUidOrElseThrow()) {
      throw Exception('login user and like user is not matched');
    }
    // 좋아요 삭제
    await _fireStore
        .collection(CollectionName.post.name)
        .doc(postId)
        .collection(CollectionName.like.name)
        .doc(likeId)
        .delete();
    // post에서 numLike필드 감소
    await _fireStore
        .collection(CollectionName.post.name)
        .doc(postId)
        .update({'numLike': FieldValue.increment(-1)});
    return likeId;
  }

  String _getCurrentUidOrElseThrow() {
    final currentUid = _auth.currentUser?.uid;
    if (currentUid == null) {
      throw Exception('not login');
    }
    return currentUid;
  }
}
