import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:portfolio/features/feed/domain/entity/comment/feed_comment.entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../main/core/constant/response_wrapper.dart';
import '../datasource/comment/feed_comment.datasource_impl.dart';
import '../model/comment/feed_comment.model.dart';

part '../../domain/repository/feed_comment.repository.dart';

@LazySingleton(as: FeedCommentRepository)
class FeedCommentRepositoryImpl implements FeedCommentRepository {
  final FeedCommentDataSource _dataSource;
  final Logger _logger = Logger();

  FeedCommentRepositoryImpl(this._dataSource);

  @override
  Future<ResponseWrapper<void>> createComment(FeedCommentEntity model) async {
    try {
      return await _dataSource
          .createComment(FeedCommentModel.fromEntity(model))
          .then(ResponseWrapper.success);
    } on PostgrestException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('create comment fails');
    }
  }

  @override
  Future<ResponseWrapper<void>> deleteCommentById(String commentId) async {
    try {
      return await _dataSource
          .deleteCommentById(commentId)
          .then(ResponseWrapper.success);
    } on PostgrestException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('delete comment fails');
    }
  }

  @override
  Future<ResponseWrapper<List<FeedCommentEntity>>> fetchComments(
      {required DateTime beforeAt,
      required String feedId,
      int take = 20,
      bool ascending = true}) async {
    try {
      return await _dataSource
          .fetchComments(
              beforeAt: beforeAt,
              feedId: feedId,
              take: take,
              ascending: ascending)
          .then((res) => res.map(FeedCommentEntity.fromRpcModel).toList())
          .then(ResponseWrapper.success);
    } on PostgrestException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('fetch comment fails');
    }
  }
}
