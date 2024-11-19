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
  CreateFeedCommentUseCase get createOnFeed =>
      CreateFeedCommentUseCase(_repository);

  @lazySingleton
  CreateReelsCommentUseCase get createOnReels =>
      CreateReelsCommentUseCase(_repository);

  @lazySingleton
  FetchCommentOnFeedUseCase get fetchOnFeed =>
      FetchCommentOnFeedUseCase(_repository);

  @lazySingleton
  FetchCommentOnReelsUseCase get fetchOnReels =>
      FetchCommentOnReelsUseCase(_repository);

  @lazySingleton
  DeleteCommentUseCase get delete => DeleteCommentUseCase(_repository);
}
