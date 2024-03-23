import 'dart:io';

import 'package:hot_place/data/model/post/comment/post_comment.model.dart';

import '../../model/post/like/like.model.dart';
import '../../model/post/post.model.dart';

abstract class PostDataSource {
  /// post
  Stream<List<PostModel>> getPostStream({int skip, int take});

  Future<PostModel> findPostById(String postId);

  Future<String> createPost(PostModel post);

  Future<String> modifyPost(PostModel post);

  Future<String> deletePostById(String postId);

  Future<String> uploadImage(File image);

  /// like
  Future<LikeModel?> getLike(String postId);

  Future<String> likePost(String postId);

  Future<String> cancelLikePost(
      {required String postId, required String likeId});

  /// comment
  Stream<List<PostCommentModel>> getCommentStream(
      {required String postId, String? parentCommentId});

  Future<String> createComment(PostCommentModel comment);

  Future<String> modifyComment(PostCommentModel comment);

  Future<String> deleteCommentById(
      {required String postId, required String commentId});
}
