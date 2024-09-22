import 'dart:io';

import 'package:flutter_app/auth/auth.export.dart';
import 'package:flutter_app/auth/domain/domain.export.dart';
import 'package:flutter_app/comment/data/dto/save_comment.dto.dart';
import 'package:flutter_app/feed/data/data.export.dart';
import 'package:flutter_app/feed/data/dto/edit_feed.dto.dart';
import 'package:flutter_app/feed/domain/domain.export.dart';
import 'package:flutter_app/feed/domain/entity/feed_comment.entity.dart';
import 'package:flutter_app/like/data/data.export.dart';
import 'package:flutter_app/shared/shared.export.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../comment/comment.export.dart';
import '../../../like/like.export.dart';
import '../dto/create_feed.dto.dart';

part 'repository.dart';

@LazySingleton(as: FeedRepository)
class FeedRepositoryImpl extends FeedRepository {
  final AuthDataSource _authDataSource;
  final FeedDataSource _feedDataSource;
  final StorageDataSource _storageDataSource;
  final LikeDataSource _likeDataSource;
  final CommentDataSource _commentDataSource;

  FeedRepositoryImpl(
      {required AuthDataSource authDataSource,
      required FeedDataSource feedDataSource,
      required StorageDataSource storageDataSource,
      required LikeDataSource likeDataSource,
      required CommentDataSource commentDataSource})
      : _authDataSource = authDataSource,
        _feedDataSource = feedDataSource,
        _storageDataSource = storageDataSource,
        _likeDataSource = likeDataSource,
        _commentDataSource = commentDataSource;

  @override
  Future<RepositoryResponseWrapper<void>> createFeed(
      {required String feedId,
      required String media,
      required String caption,
      required List<String> hashtags}) async {
    try {
      return await _feedDataSource
          .createFeed(CreateFeedDto(
              id: feedId, media: media, caption: caption, hashtags: hashtags))
          .then(RepositorySuccess<void>.from);
    } on Exception catch (error) {
      return RepositoryError<void>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<void>> deleteFeedById(String feedId) async {
    try {
      return await _feedDataSource
          .deleteFeedById(feedId)
          .then(RepositorySuccess<void>.from);
    } on Exception catch (error) {
      return RepositoryError<void>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<void>> editFeed(
      {required String feedId,
      String? media,
      String? caption,
      List<String>? hashtags}) async {
    try {
      return await _feedDataSource
          .editFeed(EditFeedDto(
              id: feedId, media: media, caption: caption, hashtags: hashtags))
          .then(RepositorySuccess<void>.from);
    } on Exception catch (error) {
      return RepositoryError<void>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<List<FeedEntity>>> fetchFeeds(
      {required DateTime beforeAt, int take = 20}) async {
    try {
      return await _feedDataSource
          .fetchFeedsByRPC(beforeAt: beforeAt, take: take)
          .then((res) => res.map(FeedEntity.from).toList())
          .then(RepositorySuccess<List<FeedEntity>>.from);
    } on Exception catch (error) {
      return RepositoryError<List<FeedEntity>>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<String>> uploadFeedImage(File feedImage,
      {bool upsert = false}) async {
    try {
      return await _storageDataSource
          .uploadImage(
              file: feedImage, bucketName: Buckets.feeds.name, upsert: upsert)
          .then(RepositorySuccess<String>.from);
    } on Exception catch (error) {
      return RepositoryError<String>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<String>> saveLike(String feedId) async {
    try {
      return await _likeDataSource
          .saveLike(SaveLikeDto(
              id: const Uuid().v4(),
              reference_id: feedId,
              reference_table: Tables.feeds))
          .then(RepositorySuccess<String>.from);
    } on Exception catch (error) {
      return RepositoryError<String>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<void>> deleteLike(String feedId) async {
    try {
      return await _likeDataSource
          .deleteLike(referenceId: feedId, referenceTable: Tables.feeds)
          .then(RepositorySuccess<void>.from);
    } on Exception catch (error) {
      return RepositoryError<void>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<List<ParentFeedCommentEntity>>>
      fetchParentComments(
          {required String feedId,
          required DateTime beforeAt,
          int take = 20}) async {
    try {
      return await _commentDataSource
          .fetchParentComments(
              referenceId: feedId,
              referenceTable: Tables.feeds.name,
              beforeAt: beforeAt,
              take: take)
          .then((res) => res
              .map((item) => ParentFeedCommentEntity.from(item, feedId: feedId))
              .toList())
          .then(RepositorySuccess<List<ParentFeedCommentEntity>>.from);
    } on Exception catch (error) {
      return RepositoryError<List<ParentFeedCommentEntity>>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<List<ChildFeedCommentEntity>>>
      fetchChildComments(
          {required String feedId,
          required String parentId,
          required DateTime beforeAt,
          int take = 20}) async {
    try {
      return await _commentDataSource
          .fetchChildComments(
              referenceId: feedId,
              referenceTable: Tables.feeds.name,
              parentId: parentId,
              beforeAt: beforeAt,
              take: take)
          .then((res) => res
              .map((item) => ChildFeedCommentEntity.from(item, feedId: feedId))
              .toList())
          .then(RepositorySuccess<List<ChildFeedCommentEntity>>.from);
    } on Exception catch (error) {
      return RepositoryError<List<ChildFeedCommentEntity>>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<void>> deleteCommentById(
      String commentId) async {
    try {
      return await _commentDataSource
          .deleteCommentById(commentId)
          .then((_) => const RepositorySuccess<void>(data: null));
    } on Exception catch (error) {
      return RepositoryError<void>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<ParentFeedCommentEntity>> saveParentComment(
      {required String feedId, required String content}) async {
    try {
      final commentId = const Uuid().v4();
      return await _commentDataSource
          .saveComment(SaveCommentDto(
              id: commentId,
              reference_id: feedId,
              reference_table: Tables.feeds.name,
              content: content))
          .then((_) => RepositorySuccess<ParentFeedCommentEntity>(
              data: ParentFeedCommentEntity(
                  id: commentId,
                  content: content,
                  author:
                      PresenceEntity.fromSupUser(_authDataSource.currentUser!),
                  createdAt: DateTime.now().toUtc())));
    } on Exception catch (error) {
      return RepositoryError<ParentFeedCommentEntity>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<ChildFeedCommentEntity>> saveChildComment(
      {required String feedId,
      required String? parentId,
      required String content}) async {
    try {
      final commentId = const Uuid().v4();
      return await _commentDataSource
          .saveComment(SaveCommentDto(
              id: commentId,
              reference_id: feedId,
              reference_table: Tables.feeds.name,
              parent_id: parentId,
              content: content))
          .then((_) => RepositorySuccess<ChildFeedCommentEntity>(
              data: ChildFeedCommentEntity(
                  id: commentId,
                  content: content,
                  author:
                      PresenceEntity.fromSupUser(_authDataSource.currentUser!),
                  parentId: parentId,
                  createdAt: DateTime.now().toUtc())));
    } on Exception catch (error) {
      return RepositoryError<ChildFeedCommentEntity>.from(error);
    }
  }
}
