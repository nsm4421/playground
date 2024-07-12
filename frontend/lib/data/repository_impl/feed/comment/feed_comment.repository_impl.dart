import 'package:fpdart/src/either.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/data_source/feed/comment/remote_data_source.dart';
import 'package:hot_place/data/entity/feed/comment/feed_comment.entity.dart';
import 'package:hot_place/domain/model/feed/comment/feed_comment.model.dart';
import 'package:hot_place/domain/repository/feed/comment/feed_comment.repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/custom_exception.dart';

@LazySingleton(as: FeedCommentRepository)
class FeedCommentRepositoryImpl implements FeedCommentRepository {
  final RemoteFeedCommentDataSource _dataSource;

  FeedCommentRepositoryImpl(this._dataSource);

  @override
  Either<Failure, Stream<List<FeedCommentEntity>>> getFeedCommentStream(
      String feedId,
      {bool ascending = false}) {
    try {
      final stream = _dataSource
          .getFeedCommentStream(feedId, ascending: ascending)
          .asyncMap(
              (event) async => event.map(FeedCommentEntity.fromModel).toList());
      return right(stream);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFeedCommentById(String commentId) async {
    try {
      await _dataSource.deleteFeedCommentById(commentId);
      return right(null);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> upsertFeedComment(
      FeedCommentEntity comment) async {
    try {
      await _dataSource.upsertFeedComment(FeedCommentModel.fromEntity(comment));
      return right(null);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }
}
