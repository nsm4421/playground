import 'dart:io';

import 'package:hot_place/domain/entity/post/post.entity.dart';

import '../../../data/model/response/response.model.dart';

abstract class PostRepository {
  ResponseModel<Stream<List<PostEntity>>> getPostStream({int skip, int take});

  Future<ResponseModel<PostEntity>> findPostById(String postId);

  Future<ResponseModel<String>> createPost(PostEntity post);

  Future<ResponseModel<String>> modifyPost(PostEntity post);

  Future<ResponseModel<String>> deletePostById(String postId);

  Future<ResponseModel<List<String>>> uploadImages(List<File> images);

  Future<ResponseModel<String>> likePost(String postId);

  Future<ResponseModel<String>> cancelLikePost(
      {required String postId, required String likeId});
}
