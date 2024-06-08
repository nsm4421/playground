import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/exception/failure.dart';
import 'package:my_app/data/datasource/feed/feed_comment.datasource_impl.dart';
import 'package:my_app/data/entity/feed/feed_comment.entity.dart';
import 'package:my_app/domain/model/feed/feed_comment.model.dart';

import '../../../core/exception/custom_exception.dart';

part 'package:my_app/domain/repository/feed/feed_comment.repository.dart';

@LazySingleton(as: FeedCommentRepository)
class FeedCommentRepositoryImpl implements FeedCommentRepository {
  final RemoteFeedCommentDataSource _remoteDataSource;

  FeedCommentRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<FeedCommentEntity>>> fetchComments(
      {required String afterAt,
      required String feedId,
      int take = 20,
      bool descending = false}) async {
    try {
      return await _remoteDataSource
          .fetchComments(
              afterAt: afterAt,
              take: take,
              feedId: feedId,
              descending: descending)
          .then((event) => event.map(FeedCommentEntity.fromModel).toList())
          .then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Either<Failure, Stream<List<FeedCommentEntity>>> getCommentStream(
      {required String afterAt,
      required String feedId,
      bool descending = false}) {
    try {
      final stream = _remoteDataSource
          .getCommentStream(
              afterAt: afterAt, feedId: feedId, descending: descending)
          .asyncMap((event) => event.map(FeedCommentEntity.fromModel).toList());
      return right(stream);
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
