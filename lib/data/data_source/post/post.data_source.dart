import 'dart:io';

import 'package:hot_place/data/model/post/post.model.dart';

abstract class PostDataSource {
  Stream<List<PostModel>> getPostStream({int skip, int take});

  Future<PostModel> findPostById(String postId);

  Future<String> createPost(PostModel post);

  Future<String> modifyPost(PostModel post);

  Future<String> deletePostById(String postId);

  Future<String> uploadImage(File image);
}
