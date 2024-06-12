import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/exception/failure.dart';
import 'package:my_app/data/datasource/feed/comment/feed_comment.datasource_impl.dart';
import 'package:my_app/data/datasource/user/account/account.datasource_impl.dart';
import 'package:my_app/data/entity/feed/comment/feed_comment.entity.dart';
import 'package:my_app/data/entity/user/account.entity.dart';
import 'package:my_app/domain/model/feed/comment/feed_comment.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/exception/custom_exception.dart';

part 'package:my_app/domain/repository/feed/feed_comment.repository.dart';

@LazySingleton(as: FeedCommentRepository)
class FeedCommentRepositoryImpl implements FeedCommentRepository {
  final RemoteFeedCommentDataSource _remoteFeedCommentDataSource;
  final RemoteAccountDataSource _remoteAccountDataSource;

  FeedCommentRepositoryImpl(
      {required RemoteFeedCommentDataSource remoteFeedCommentDataSource,
      required RemoteAccountDataSource remoteAccountDataSource})
      : _remoteFeedCommentDataSource = remoteFeedCommentDataSource,
        _remoteAccountDataSource = remoteAccountDataSource;

  @override
  Future<Either<Failure, List<FeedCommentEntity>>> fetchComments(
      {required DateTime beforeAt,
      required String feedId,
      required int from,
      required int to,
      bool ascending = false}) async {
    try {
      return await _remoteFeedCommentDataSource
          .fetchComments(
              beforeAt: beforeAt,
              feedId: feedId,
              from: from,
              to: to,
              ascending: ascending)
          .then(
              (res) => res.map(FeedCommentEntity.fromModelWithAuthor).toList())
          .then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteComment(String commentId) async {
    try {
      return await _remoteFeedCommentDataSource
          .deleteComment(commentId)
          .then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> modifyComment(
      {required String commentId, required String content}) async {
    try {
      return await _remoteFeedCommentDataSource
          .modifyComment(commentId: commentId, content: content)
          .then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> saveComment(FeedCommentEntity entity) async {
    try {
      return await _remoteFeedCommentDataSource
          .saveComment(FeedCommentModel.fromEntity(entity))
          .then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  RealtimeChannel getCommentChannel(
      {required String feedId,
      required PostgresChangeEvent changeEvent,
      required void Function(
              FeedCommentEntity? oldRecord, FeedCommentEntity? newRecord)
          callback}) {
    return _remoteFeedCommentDataSource.getCommentChannel(
        feedId: feedId,
        changeEvent: changeEvent,
        callback: (PostgresChangePayload p) async {
          FeedCommentEntity? oldRecord = FeedCommentEntity.fromModel(
              FeedCommentModel.fromJson(p.oldRecord));
          FeedCommentEntity? newRecord = FeedCommentEntity.fromModel(
              FeedCommentModel.fromJson(p.newRecord));
          oldRecord = (oldRecord.id == null)
              ? null
              : oldRecord.copyWith(
                  author: AccountEntity.fromModel(await _remoteAccountDataSource
                      .findByUserId(oldRecord.createdBy!)));
          newRecord = (newRecord.id == null)
              ? null
              : newRecord.copyWith(
                  author: AccountEntity.fromModel(await _remoteAccountDataSource
                      .findByUserId(newRecord.createdBy!)));
          callback(oldRecord, newRecord);
        });
  }
}
