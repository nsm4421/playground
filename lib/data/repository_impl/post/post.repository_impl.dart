import 'dart:io';

import 'package:hot_place/core/constant/response.constant.dart';
import 'package:hot_place/data/data_source/post/post.data_source.dart';
import 'package:hot_place/data/data_source/user/user.data_source.dart';
import 'package:hot_place/data/model/post/comment/post_comment.model.dart';
import 'package:hot_place/domain/entity/post/comment/post_comment.entity.dart';
import 'package:hot_place/domain/entity/post/post.entity.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';
import 'package:hot_place/domain/repository/post/post.repository.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../model/post/post.model.dart';
import '../../model/response/response.model.dart';

@Singleton(as: PostRepository)
class PostRepositoryImpl extends PostRepository {
  final UserDataSource _userDataSource;
  final PostDataSource _postDataSource;

  PostRepositoryImpl(
      {required PostDataSource postDataSource,
      required UserDataSource userDataSource})
      : _postDataSource = postDataSource,
        _userDataSource = userDataSource;

  final _logger = Logger();

  /// post
  @override
  ResponseModel<Stream<List<PostEntity>>> getPostStream(
      {int skip = 0, int take = 100}) {
    try {
      final stream = _postDataSource
          .getPostStream(skip: skip, take: take)
          .asyncMap((posts) async => await Future.wait(posts.map((post) async {
                final author = await _findUserByIdOrElseThrow(post.authorUid);
                final like = await _postDataSource.getLike(post.id);
                return PostEntity.fromModel(
                    post: post, author: author, like: like);
              })));
      return ResponseModel.success(data: stream);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<Stream<List<PostEntity>>>.error();
    }
  }

  @override
  Future<ResponseModel<String>> createPost(PostEntity post) async {
    try {
      final postId =
          await _postDataSource.createPost(PostModel.fromEntity(post));
      return ResponseModel<String>.success(data: postId);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<String>.error();
    }
  }

  @override
  Future<ResponseModel<String>> deletePostById(String postId) async {
    try {
      final savedPostId = await _postDataSource.deletePostById(postId);
      return ResponseModel.success(
          responseType: ResponseType.ok, data: savedPostId);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<String>.error();
    }
  }

  @override
  Future<ResponseModel<PostEntity>> findPostById(String postId) async {
    try {
      final postModel = await _postDataSource.findPostById(postId);
      final userEntity = await _findUserByIdOrElseThrow(postModel.authorUid);
      final postEntity =
          PostEntity.fromModel(post: postModel, author: userEntity);
      return ResponseModel.success(data: postEntity);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<PostEntity>.error();
    }
  }

  @override
  Future<ResponseModel<String>> modifyPost(PostEntity post) async {
    try {
      final postId =
          await _postDataSource.modifyPost(PostModel.fromEntity(post));
      return ResponseModel.success(data: postId);
    } catch (err) {
      _logger.e(err);
      return ResponseModel.error();
    }
  }

  @override
  Future<ResponseModel<List<String>>> uploadImages(List<File> images) async {
    try {
      final futures =
          images.map((e) async => await _postDataSource.uploadImage(e));
      final urls = await Future.wait(futures);
      return ResponseModel.success(data: urls);
    } catch (err) {
      _logger.e(err);
      return ResponseModel.error();
    }
  }

  /// like
  @override
  Future<ResponseModel<String>> likePost(String postId) async {
    try {
      final likeId = await _postDataSource.likePost(postId);
      return ResponseModel.success(data: likeId);
    } catch (err) {
      _logger.e(err);
      return ResponseModel.error();
    }
  }

  @override
  Future<ResponseModel<String>> cancelLikePost({
    required String postId,
    required String likeId,
  }) async {
    try {
      await _postDataSource.cancelLikePost(postId: postId, likeId: likeId);
      return ResponseModel.success(data: likeId);
    } catch (err) {
      _logger.e(err);
      return ResponseModel.error();
    }
  }

/// comment

  @override
  Future<ResponseModel<String>> createPostComment(
      PostCommentEntity comment) async {
    try {
      final commentId = await _postDataSource
          .createComment(PostCommentModel.fromEntity(comment));
      return ResponseModel.success(data: commentId);
    } catch (err) {
      _logger.e(err);
      return ResponseModel.error();
    }
  }

  @override
  Future<ResponseModel<String>> deletePostCommentById(
      {required String postId, required String commentId}) async {
    try {
      await _postDataSource.deleteCommentById(
          postId: postId, commentId: commentId);
      return ResponseModel.success(data: commentId);
    } catch (err) {
      _logger.e(err);
      return ResponseModel.error();
    }
  }

  @override
  Future<ResponseModel<String>> modifyPostComment(
      PostCommentEntity comment) async {
    try {
      final commentId = await _postDataSource
          .modifyComment(PostCommentModel.fromEntity(comment));
      return ResponseModel.success(data: commentId);
    } catch (err) {
      _logger.e(err);
      return ResponseModel.error();
    }
  }

  Future<UserEntity> _findUserByIdOrElseThrow(String uid) async {
    final user = await _userDataSource.findUserById(uid);
    if (user == null) {
      throw Exception('user not found');
    }
    return UserEntity.fromModel(user);
  }
}
