import 'dart:io';

import 'package:flutter_app/reels/domain/entity/reels.entity.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/shared.export.dart';
import '../../data/repository/repository_impl.dart';

part 'scenario/create_reels.dart';

part 'scenario/delete_reels.dart';

part 'scenario/edit_reels.dart';

part 'scenario/fetch_reels.dart';

@lazySingleton
class ReelsUseCase {
  final ReelsRepository _repository;

  ReelsUseCase(this._repository);

  FetchReelsUseCase get fetchReels => FetchReelsUseCase(_repository);

  CreateReelsUseCase get createReels => CreateReelsUseCase(_repository);

  EditReelsUseCase get editReels => EditReelsUseCase(_repository);

  DeleteReelsUseCase get deleteReels => DeleteReelsUseCase(_repository);
}
