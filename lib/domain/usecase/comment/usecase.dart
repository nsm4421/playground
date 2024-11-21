import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/data/model/error/error_response.dart';
import 'package:travel/domain/entity/comment/comment.dart';
import 'package:travel/domain/repository/repository.dart';

part 'create.dart';

part 'fetch.dart';

part 'delete.dart';

@lazySingleton
class CommentUseCase {
  final CommentRepository _repository;

  CommentUseCase(this._repository);

  @lazySingleton
  CreateCommentUseCase get create => CreateCommentUseCase(_repository);

  @lazySingleton
  FetchCommentUseCase get fetch => FetchCommentUseCase(_repository);

  @lazySingleton
  DeleteCommentUseCase get delete => DeleteCommentUseCase(_repository);
}
