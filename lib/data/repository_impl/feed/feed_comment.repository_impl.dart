import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/exception/failure.dart';
import 'package:my_app/data/datasource/feed/comment/feed_comment.datasource_impl.dart';
import 'package:my_app/data/entity/feed/comment/feed_comment.entity.dart';
import 'package:my_app/domain/model/feed/comment/feed_comment.model.dart';

import '../../../core/exception/custom_exception.dart';

part 'package:my_app/domain/repository/feed/feed_comment.repository.dart';

@LazySingleton(as: FeedCommentRepository)
class FeedCommentRepositoryImpl implements FeedCommentRepository {
  final RemoteFeedCommentDataSource _remoteDataSource;

  FeedCommentRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<FeedCommentEntity>>> fetchComments(
      {required DateTime beforeAt,
      required String feedId,
      required int from,
      required int to,
      bool ascending = false}) async {
    try {
      return await _remoteDataSource
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
      return await _remoteDataSource.deleteComment(commentId).then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> modifyComment(
      {required String commentId, required String content}) async {
    try {
      return await _remoteDataSource
          .modifyComment(commentId: commentId, content: content)
          .then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> saveComment(FeedCommentEntity entity) async {
    try {
      return await _remoteDataSource
          .saveComment(FeedCommentModel.fromEntity(entity))
          .then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }
}
