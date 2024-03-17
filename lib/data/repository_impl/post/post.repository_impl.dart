import 'dart:io';

import 'package:hot_place/core/constant/response.constant.dart';
import 'package:hot_place/data/data_source/post/post.data_source.dart';
import 'package:hot_place/data/data_source/user/user.data_source.dart';
import 'package:hot_place/data/model/user/user.model.dart';
import 'package:hot_place/domain/entity/post/post.entity.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';
import 'package:hot_place/domain/repository/post/post.repository.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

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

  @override
  ResponseModel<Stream<List<PostEntity>>> getPostStream(
      {int skip = 0, int take = 100}) {
    try {
      final stream = _postDataSource
          .getPostStream(skip: skip, take: take)
          .asyncMap((posts) async => await Future.wait(posts.map((post) async {
                final author =
                    await _userDataSource.findUserById(post.authorUid);
                return PostEntity.fromModel(
                    post: post, author: author.toEntity());
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
      final postId = await _postDataSource.createPost(post.toModel());
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
      final userEntity = UserEntity.fromModel(
          await _userDataSource.findUserById(postModel.authorUid));
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
      final postId = await _postDataSource.modifyPost(post.toModel());
      return ResponseModel.success(data: postId);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<String>.error();
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
      return ResponseModel<List<String>>.error();
    }
  }
}
