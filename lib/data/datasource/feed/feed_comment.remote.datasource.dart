part of '../export.datasource.dart';

abstract interface class FeedCommentRemoteDataSource {
  Future<CommentDto> create({required String content, required int feedId});

  Future<Pageable<CommentDto>> fetch(
      {required int page,
      int pageSize = 20,
      required int feedId,
      bool showLog = true});

  Future<CommentDto> modify(
      {required String content, required int commentId});

  Future<void> deleteById(int commentId);
}
