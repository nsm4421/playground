import 'package:hot_place/data/model/post/post.model.dart';

abstract class PostDataSource {
  Future<PostModel> findPostById(String postId);

  Future<String> createPost(PostModel post);

  Future<String> modifyPost(PostModel post);

  Future<String> deletePostById(String postId);
}
