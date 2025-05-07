part of '../export.datasource.dart';

abstract interface class $CommentDataSource {
  Future<CommentDto> $create(
      {required CommentReference ref, required Map<String, dynamic> payload});

  Future<CommentDto> $modify(
      {required CommentReference ref, required Map<String, dynamic> payload});

  Future<Pageable<CommentDto>> $fetch(
      {required int page,
      int pageSize = 20,
      required CommentReference ref,
      required int refId});

  Future<void> $delete({required CommentReference ref, required int commentId});
}
