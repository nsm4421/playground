import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:travel/core/response/response_wrapper.dart';
import 'package:travel/domain/repository/diary/repository.dart';

part 'scenario/crud.dart';

@lazySingleton
class DiaryUseCase {
  final DiaryRepository _repository;

  DiaryUseCase(this._repository);

  EditDiaryUseCase get edit => EditDiaryUseCase(_repository);

  DeleteDiaryUseCase get delete => DeleteDiaryUseCase(_repository);
}
