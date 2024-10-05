import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/core/response/error_response.dart';
import 'package:travel/domain/repository/diary/repository.dart';

part 'scenario/crud.dart';

class DiaryUseCase {
  final DiaryRepository _repository;

  DiaryUseCase(this._repository);

  EditDiaryUseCase get edit => EditDiaryUseCase(_repository);

  DeleteDiaryUseCase get delete => DeleteDiaryUseCase(_repository);
}
