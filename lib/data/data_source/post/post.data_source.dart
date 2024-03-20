import 'dart:io';

import '../../model/post/like/like.model.dart';
import '../../model/post/post.model.dart';

abstract class PostDataSource {
  Stream<List<PostModel>> getPostStream({int skip, int take});

  Future<PostModel> findPostById(String postId);

  Future<String> createPost(PostModel post);

  Future<String> modifyPost(PostModel post);

  Future<String> deletePostById(String postId);

  Future<String> uploadImage(File image);

  Future<LikeModel?> getLike(String postId);

  Future<String> likePost(String postId);

  Future<String> cancelLikePost(
      {required String postId, required String likeId});
}
