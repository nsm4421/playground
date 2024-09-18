import 'package:flutter_app/comment/domain/entity/comment.entity.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/shared.export.dart';
import '../../data/repository/repository_impl.dart';

part 'scenario/save_comment.dart';

part 'scenario/fetch_parent_comment.dart';

part 'scenario/fetch_child_comment.dart';

part 'scenario/delete_comment.dart';

@lazySingleton
class CommentUseCase {
  final CommentRepository _repository;

  CommentUseCase(this._repository);

  SaveFeedCommentUseCase get saveFeed => SaveFeedCommentUseCase(_repository);

  FetchParentFeedCommentUseCase get fetchParentFeedComment =>
      FetchParentFeedCommentUseCase(_repository);

  FetchChildFeedCommentUseCase get fetchChildFeedComment =>
      FetchChildFeedCommentUseCase(_repository);

  DeleteCommentUseCase get deleteComment => DeleteCommentUseCase(_repository);
}
