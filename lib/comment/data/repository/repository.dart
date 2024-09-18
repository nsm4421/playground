part of 'repository_impl.dart';

abstract class CommentRepository {
  Future<RepositoryResponseWrapper<List<CommentEntity>>> fetchParentComments(
      {required String referenceId,
      required Tables referenceTable,
      required DateTime beforeAt,
      int take = 20});

  Future<RepositoryResponseWrapper<List<CommentEntity>>> fetchChildComments(
      {required String referenceId,
      required Tables referenceTable,
      required String parentId,
      required DateTime beforeAt,
      int take = 20});

  Future<RepositoryResponseWrapper<void>> saveComment(
      {required String referenceId,
      required Tables referenceTable,
      String? parentId,
      required String content});

  Future<RepositoryResponseWrapper<void>> deleteCommentById(String commentId);
}
