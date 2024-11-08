import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/data/model/error/error_response.dart';
import 'package:travel/domain/entity/feed/feed.dart';
import 'package:travel/domain/repository/repository.dart';

part 'create.dart';

part 'fetch.dart';

part 'edit.dart';

part 'delete.dart';

@lazySingleton
class FeedUseCase {
  final FeedRepository _feedRepository;

  FeedUseCase(this._feedRepository);

  @lazySingleton
  CreateFeedUseCase get create => CreateFeedUseCase(_feedRepository);

  @lazySingleton
  FetchFeedUseCase get fetch => FetchFeedUseCase(_feedRepository);

  @lazySingleton
  EditFeedUseCase get edit => EditFeedUseCase(_feedRepository);

  @lazySingleton
  DeleteFeedUseCase get delete => DeleteFeedUseCase(_feedRepository);
}
