import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hot_place/core/constant/firebase.constant.dart';
import 'package:hot_place/core/util/uuid.util.dart';
import 'package:hot_place/data/data_source/post/post.data_source.dart';
import 'package:hot_place/data/model/post/comment/post_comment.model.dart';
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
  Future<PostModel> findPostById(String postId) async => await _fireStore
      .collection(CollectionName.post.name)
      .doc(postId)
      .get()
      .then((snapshot) => snapshot.data())
      .then((data) => PostModel.fromJson(data ?? {}));

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
  Future<String> modifyPost(PostModel post) async {
    final fetched = await _getPostIfAuthorOrElseThrow(post.id);
    await _fireStore.collection(CollectionName.post.name).doc(post.id).set(
        fetched
            .copyWith(
                content: post.content,
                images: post.images,
                hashtags: post.hashtags)
            .toJson());
    return post.id;
  }

  @override
  Future<String> deletePostById(String postId) async {
    await _getPostIfAuthorOrElseThrow(postId);
    await _fireStore.collection(CollectionName.post.name).doc(postId).delete();
    return postId;
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

  @override
  Stream<List<PostCommentModel>> getCommentStream(
          {required String postId, String? parentCommentId}) =>
      _fireStore
          .collection(CollectionName.post.name)
          .doc(postId)
          .collection(CollectionName.postComment.name)
          // parentCommentId = null -> 댓글 조회
          // parentCommentId != null -> 대댓글 조회
          .where("parentCommentId", isEqualTo: parentCommentId)
          // parentCommentId = null -> 작성시간별 내림차순
          // parentCommentId != null -> 작성시간별 오름차순
          .orderBy("createdAt", descending: parentCommentId == null)
          .snapshots()
          .asyncMap((snapshot) => snapshot.docs
              .map((doc) => PostCommentModel.fromJson(doc.data()))
              .toList());

  @override
  Future<String> createComment(PostCommentModel comment) async {
    final commentId = comment.id.isNotEmpty ? comment.id : UuidUtil.uuid();
    await _fireStore
        .collection(CollectionName.post.name)
        .doc(comment.postId)
        .collection(CollectionName.postComment.name)
        .doc(commentId)
        .set(comment
            .copyWith(
                id: commentId,
                uid: _getCurrentUidOrElseThrow(),
                createdAt: DateTime.now())
            .toJson());
    return commentId;
  }

  @override
  Future<String> modifyComment(PostCommentModel comment) async {
    final fetched = await _getCommentIfAuthorOrElseThrow(
        postId: comment.postId, commentId: comment.id);
    // 본문 수정
    await _fireStore
        .collection(CollectionName.post.name)
        .doc(comment.postId)
        .collection(CollectionName.postComment.name)
        .doc(comment.id)
        .set(fetched.copyWith(content: comment.content).toJson());
    return comment.id;
  }

  @override
  Future<String> deleteComment(
      {required String postId, required String commentId}) async {
    await _getCommentIfAuthorOrElseThrow(postId: postId, commentId: commentId);
    // 댓글 삭제
    await _fireStore
        .collection(CollectionName.post.name)
        .doc(postId)
        .collection(CollectionName.postComment.name)
        .doc(commentId)
        .delete();
    return commentId;
  }

  String _getCurrentUidOrElseThrow() {
    final currentUid = _auth.currentUser?.uid;
    if (currentUid == null) {
      throw Exception('not login');
    }
    return currentUid;
  }

  Future<PostModel> _getPostIfAuthorOrElseThrow(String postId) async {
    final post = await _fireStore
        .collection(CollectionName.post.name)
        .doc(postId)
        .get()
        .then((snapshot) => snapshot.data())
        .then((data) => PostModel.fromJson(data ?? {}));
    if (post.authorUid != _getCurrentUidOrElseThrow()) {
      throw Exception('author and login user are not same');
    }
    return post;
  }

  Future<PostCommentModel> _getCommentIfAuthorOrElseThrow(
      {required String postId, required String commentId}) async {
    final comment = await _fireStore
        .collection(CollectionName.post.name)
        .doc(postId)
        .collection(CollectionName.postComment.name)
        .doc(commentId)
        .get()
        .then((snapshot) => snapshot.data())
        .then((data) => PostCommentModel.fromJson(data ?? {}));
    if (comment.uid != _getCurrentUidOrElseThrow()) {
      throw Exception('author and login user are not same');
    }
    return comment;
  }
}
