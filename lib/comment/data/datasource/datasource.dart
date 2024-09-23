part of 'datasource_impl.dart';

abstract class CommentDataSource {
  Future<Iterable<FetchParentCommentDto>> fetchParentComments(
      {required String referenceId,
      required String referenceTable,
      required DateTime beforeAt,
      int take = 20});

  Future<Iterable<FetchChildCommentDto>> fetchChildComments(
      {required String referenceId,
      required String referenceTable,
      required String parentId,
      required DateTime beforeAt,
      int take = 20});

  Future<void> saveComment(SaveCommentDto dto);

  Future<void> deleteCommentById(String commentId);
}
