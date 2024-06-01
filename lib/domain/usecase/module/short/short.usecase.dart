import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constant/error_code.dart';
import '../../../../core/exception/failure.dart';
import '../../../../data/entity/short/short.entity.dart';
import '../../../repository/short/short.repository.dart';

part '../../case/short/upload_video.usecase.dart';

part '../../case/short/save_short.usecase.dart';

part '../../case/short/get_short_url.usecase.dart';

@lazySingleton
class ShortUseCase {
  final ShortRepository _repository;

  ShortUseCase(this._repository);

  @injectable
  SaveShortUseCase get saveShort => SaveShortUseCase(_repository);

  @injectable
  UploadVideoUseCase get uploadVideo => UploadVideoUseCase(_repository);

  @injectable
  GetShortUrlUseCase get getShortUrl => GetShortUrlUseCase(_repository);
}
