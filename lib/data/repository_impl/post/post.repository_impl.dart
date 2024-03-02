import 'package:hot_place/data/data_source/post/post.data_source.dart';
import 'package:hot_place/data/data_source/user/user.data_source.dart';
import 'package:hot_place/domain/entity/post/post.entity.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';
import 'package:hot_place/domain/repository/post/post.repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: PostRepository)
class PostRepositoryImpl extends PostRepository {
  final UserDataSource _userDataSource;
  final PostDataSource _postDataSource;

  PostRepositoryImpl(
      {required PostDataSource postDataSource,
      required UserDataSource userDataSource})
      : _postDataSource = postDataSource,
        _userDataSource = userDataSource;

  @override
  Future<String> createPost(PostEntity post) async =>
      await _postDataSource.createPost(post.toModel());

  @override
  Future<String> deletePostById(String postId) async =>
      await _postDataSource.deletePostById(postId);

  @override
  Future<PostEntity> findPostById(String postId) async {
    final post = await _postDataSource.findPostById(postId);
    final author = UserEntity.fromModel(
        await _userDataSource.findUserById(post.authorUid));
    return PostEntity.fromModel(post: post, author: author);
  }

  @override
  Future<String> modifyPost(PostEntity post) async =>
      await _postDataSource.modifyPost(post.toModel());
}
