import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/exception/failure.dart';
import 'package:my_app/data/datasource/feed/impl/feed_comment.remote_datasource_impl.dart';
import 'package:my_app/data/datasource/user/impl/account.remote_datasource_impl.dart';
import 'package:my_app/data/entity/feed/comment/feed_comment.entity.dart';
import 'package:my_app/data/entity/user/account.entity.dart';
import 'package:my_app/domain/model/feed/comment/fetch_feed_comment_response.dto.dart';
import 'package:my_app/domain/model/feed/comment/save_feed_comment_request.dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/exception/custom_exception.dart';
import '../../../domain/model/feed/comment/feed_comment_payload.dto.dart';

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
          .then((res) => res.map(FeedCommentEntity.fromDto).toList())
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
          .saveComment(SaveFeedCommentRequestDto.fromEntity(entity))
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
          FeedCommentEntity? oldRecord = FeedCommentEntity.fromPayload(
              FeedCommentPayloadDto.fromJson(p.oldRecord));
          FeedCommentEntity? newRecord = FeedCommentEntity.fromPayload(
              FeedCommentPayloadDto.fromJson(p.newRecord));
          oldRecord = (oldRecord.id == null || oldRecord.author?.id == null)
              ? null
              : oldRecord.copyWith(
                  author: AccountEntity.fromDto(await _remoteAccountDataSource
                      .findByUserId(oldRecord.author!.id!)));
          newRecord = (newRecord.id == null || newRecord.author?.id == null)
              ? null
              : newRecord.copyWith(
                  author: AccountEntity.fromDto(await _remoteAccountDataSource
                      .findByUserId(newRecord.author!.id!)));
          callback(oldRecord, newRecord);
        });
  }
}
