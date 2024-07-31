import 'package:injectable/injectable.dart';
import 'package:portfolio/features/feed/domain/entity/comment/feed_comment.entity.dart';
import '../../../main/core/constant/response_wrapper.dart';
import '../datasource/comment/feed_comment.datasource_impl.dart';

part '../../domain/repository/feed_comment.repository.dart';

@LazySingleton(as: FeedCommentRepository)
class FeedCommentRepositoryImpl implements FeedCommentRepository {
  final FeedCommentDataSource _dataSource;

  FeedCommentRepositoryImpl(this._dataSource);

  @override
  Future<void> createComment(FeedCommentEntity model) {
    // TODO: implement createComment
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCommentById(String commentId) {
    // TODO: implement deleteCommentById
    throw UnimplementedError();
  }

  @override
  Future<ResponseWrapper<List<FeedCommentEntity>>> fetchComments(
      {required DateTime beforeAt,
      required String feedId,
      int take = 20,
      bool ascending = true}) {
    // TODO: implement fetchComments
    throw UnimplementedError();
  }

  @override
  Future<void> cancelLikeOnComment(String commentId) {
    // TODO: implement cancelLikeOnComment
    throw UnimplementedError();
  }

  @override
  Future<void> likeOnComment(String commentId) {
    // TODO: implement likeOnComment
    throw UnimplementedError();
  }
}
