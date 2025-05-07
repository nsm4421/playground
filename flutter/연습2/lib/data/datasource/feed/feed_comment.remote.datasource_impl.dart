part of '../export.datasource.dart';

class FeedCommentRemoteDataSourceImpl extends $CommentDataSourceImpl
    implements FeedCommentRemoteDataSource {
  FeedCommentRemoteDataSourceImpl(
      {required super.dio, required super.logger, required super.showLog});

  CommentReference get _ref => CommentReference.feeds;

  @override
  Future<CommentDto> create(
      {required String content, required int feedId}) async {
    return await super
        .$create(ref: _ref, payload: {'feedId': feedId, 'content': content});
  }

  @override
  Future<void> deleteById(int commentId) async {
    return await super.$delete(ref: _ref, commentId: commentId);
  }

  @override
  Future<Pageable<CommentDto>> fetch(
      {required int page,
      int pageSize = 20,
      required int feedId,
      bool showLog = true}) async {
    return await super
        .$fetch(page: page, pageSize: pageSize, ref: _ref, refId: feedId);
  }

  @override
  Future<CommentDto> modify(
      {required String content, required int commentId}) async {
    return await super.$modify(
        ref: _ref, payload: {'commentId': commentId, 'content': content});
  }
}
