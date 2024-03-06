import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_place/core/constant/firebase.constant.dart';
import 'package:hot_place/core/util/uuid.util.dart';
import 'package:hot_place/data/data_source/post/post.data_source.dart';
import 'package:hot_place/data/model/post/post.model.dart';

class RemotePostDataSource extends PostDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _fireStore;

  RemotePostDataSource(
      {required FirebaseAuth auth, required FirebaseFirestore fireStore})
      : _auth = auth,
        _fireStore = fireStore;

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

  String _getCurrentUidOrElseThrow() {
    final currentUid = _auth.currentUser?.uid;
    if (currentUid == null) {
      throw Exception('not login');
    }
    return currentUid;
  }
}
