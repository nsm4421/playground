import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:travel/core/response/error_response.dart';
import 'package:travel/domain/entity/diary/diary.dart';
import 'package:travel/domain/repository/diary/repository.dart';

part 'scenario/crud.dart';

class DiaryUseCase {
  final DiaryRepository _repository;

  DiaryUseCase(this._repository);

  EditDiaryUseCase get edit => EditDiaryUseCase(_repository);

  FetchDiariesUseCase get fetch => FetchDiariesUseCase(_repository);

  DeleteDiaryUseCase get delete => DeleteDiaryUseCase(_repository);
}
