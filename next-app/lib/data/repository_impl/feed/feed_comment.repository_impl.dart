import 'package:injectable/injectable.dart';
import '../../../core/constant/response_wrapper.dart';
import '../../../core/util/exception.util.dart';
import '../../../domain/entity/feed/feed_comment.entity.dart';
import '../../datasource/remote/feed/impl/feed_comment.remote_datasource_impl.dart';
import '../../model/feed/comment/feed_comment.model.dart';

part '../../../domain/repository/feed/feed_comment.repository.dart';

@LazySingleton(as: FeedCommentRepository)
class FeedCommentRepositoryImpl implements FeedCommentRepository {
  final FeedCommentRemoteDataSource _dataSource;

  FeedCommentRepositoryImpl(this._dataSource);

  @override
  Future<ResponseWrapper<void>> createComment(FeedCommentEntity model) async {
    try {
      return await _dataSource
          .createComment(FeedCommentModel.fromEntity(model))
          .then(ResponseWrapper.success);
    } catch (error) {
      throw CustomException.from(error);
    }
  }

  @override
  Future<ResponseWrapper<void>> deleteCommentById(String commentId) async {
    try {
      return await _dataSource
          .deleteCommentById(commentId)
          .then(ResponseWrapper.success);
    } catch (error) {
      throw CustomException.from(error);
    }
  }

  @override
  Future<ResponseWrapper<List<FeedCommentEntity>>> fetchComments(
      {required DateTime beforeAt,
      required String feedId,
      int take = 20}) async {
    try {
      return await _dataSource
          .fetchComments(beforeAt: beforeAt, feedId: feedId, take: take)
          .then((res) => res.map(FeedCommentEntity.fromRpcModel).toList())
          .then(ResponseWrapper.success);
    } catch (error) {
      throw CustomException.from(error);
    }
  }
}
