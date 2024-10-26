import 'package:either_dart/either.dart';

import '../../../core/constant/constant.dart';
import '../../../core/response/error_response.dart';
import '../../entity/comment/comment.dart';
import '../../repository/comment/repository.dart';

part 'scenario/crud.dart';

class CommentUseCase {
  final CommentRepository _repository;

  CommentUseCase(this._repository);

  CreateCommentUseCase createComment(BaseEntity ref) =>
      CreateCommentUseCase(_repository, ref: ref);

  FetchCommentUseCase fetchComment(BaseEntity ref) =>
      FetchCommentUseCase(ref: ref, _repository);

  ModifyCommentUseCase get modify => ModifyCommentUseCase(_repository);

  DeleteCommentUseCase get delete => DeleteCommentUseCase(_repository);
}
