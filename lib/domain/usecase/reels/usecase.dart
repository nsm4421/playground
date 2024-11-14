import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/data/model/error/error_response.dart';
import 'package:travel/domain/repository/repository.dart';

part 'create.dart';

part 'edit.dart';

part 'fetch.dart';

part 'delete.dart';

@lazySingleton
class ReelsUseCase {
  final ReelsRepository _reelsRepository;

  ReelsUseCase(this._reelsRepository);

  @lazySingleton
  CreateReelsUseCase get create => CreateReelsUseCase(_reelsRepository);

  @lazySingleton
  FetchReelsUseCase get fetch => FetchReelsUseCase(_reelsRepository);

  @lazySingleton
  EditReelsUseCase get edit => EditReelsUseCase(_reelsRepository);

  @lazySingleton
  DeleteReelsUseCase get delete => DeleteReelsUseCase(_reelsRepository);
}
