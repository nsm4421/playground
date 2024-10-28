import 'dart:io';
import 'package:either_dart/either.dart';
import '../../../core/response/error_response.dart';
import '../../entity/feed/feed.dart';
import '../../repository/feed/repository.dart';

part 'scenario/crud.dart';

class FeedUseCase {
  final FeedRepository _repository;

  FeedUseCase(this._repository);

  EditFeedUseCase get edit => EditFeedUseCase(_repository);

  FetchFeedUseCase get fetch => FetchFeedUseCase(_repository);

  DeleteFeedUseCase get delete => DeleteFeedUseCase(_repository);
}
