import 'dart:io';

import 'package:hot_place/domain/entity/post/post.entity.dart';

abstract class PostRepository {
  Stream<List<PostEntity>> getPostStream({int skip, int take});

  Future<PostEntity> findPostById(String postId);

  Future<String> createPost(PostEntity post);

  Future<String> modifyPost(PostEntity post);

  Future<String> deletePostById(String postId);

  Future<List<String>> uploadImages(List<File> images);
}
