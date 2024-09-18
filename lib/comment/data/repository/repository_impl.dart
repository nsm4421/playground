import 'package:flutter_app/comment/data/dto/save_comment.dto.dart';
import 'package:flutter_app/shared/constant/constant.export.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entity/comment.entity.dart';
import '../data.export.dart';

part 'repository.dart';

@LazySingleton(as: CommentRepository)
class CommentRepositoryImpl extends CommentRepository {
  final CommentDataSource _dataSource;

  CommentRepositoryImpl(this._dataSource);

  @override
  Future<RepositoryResponseWrapper<List<CommentEntity>>> fetchParentComments(
      {required String referenceId,
      required Tables referenceTable,
      required DateTime beforeAt,
      int take = 20}) async {
    try {
      return await _dataSource
          .fetchParentComments(
              referenceId: referenceId,
              referenceTable: referenceTable,
              beforeAt: beforeAt,
              take: take)
          .then((res) => res
              .map((item) => CommentEntity.fromParentCommentDto(item,
                  referenceId: referenceId, referenceTable: referenceTable))
              .toList())
          .then(RepositorySuccess<List<CommentEntity>>.from);
    } on Exception catch (error) {
      return RepositoryError<List<CommentEntity>>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<List<CommentEntity>>> fetchChildComments(
      {required String referenceId,
      required Tables referenceTable,
      required String parentId,
      required DateTime beforeAt,
      int take = 20}) async {
    try {
      return await _dataSource
          .fetchChildComments(
              referenceId: referenceId,
              referenceTable: referenceTable,
              parentId: parentId,
              beforeAt: beforeAt,
              take: take)
          .then((res) => res
              .map((item) => CommentEntity.fromChildCommentDto(item,
                  referenceId: referenceId,
                  referenceTable: referenceTable,
                  parentId: parentId))
              .toList())
          .then(RepositorySuccess<List<CommentEntity>>.from);
    } on Exception catch (error) {
      return RepositoryError<List<CommentEntity>>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<void>> deleteCommentById(
      String commentId) async {
    try {
      return await _dataSource
          .deleteCommentById(commentId)
          .then((_) => const RepositorySuccess<void>(null));
    } on Exception catch (error) {
      return RepositoryError<void>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<void>> saveComment(
      {required String referenceId,
      required Tables referenceTable,
      String? parentId,
      required String content}) async {
    try {
      return await _dataSource
          .saveComment(SaveCommentDto(
              id: const Uuid().v4(),
              reference_id: referenceId,
              reference_table: referenceTable.name,
              parent_id: parentId,
              content: content))
          .then((_) => const RepositorySuccess<void>(null));
    } on Exception catch (error) {
      return RepositoryError<void>.from(error);
    }
  }
}
