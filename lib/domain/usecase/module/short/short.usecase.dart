import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/exception/failure.dart';
import '../../../../data/entity/short/short.entity.dart';
import '../../../repository/short/short.repository.dart';

part '../../case/short/upload_video.usecase.dart';

part '../../case/short/save_short.usecase.dart';

part '../../case/short/get_short_url.usecase.dart';

part '../../case/short/get_shorts.usecase.dart';

part '../../case/short/get_short_stream.usecase.dart';

@lazySingleton
class ShortUseCase {
  final ShortRepository _repository;

  ShortUseCase(this._repository);

  @injectable
  GetShortStreamUseCase get shortStream => GetShortStreamUseCase(_repository);

  @injectable
  GetShortsUseCase get getShorts => GetShortsUseCase(_repository);

  @injectable
  SaveShortUseCase get saveShort => SaveShortUseCase(_repository);

  @injectable
  UploadVideoUseCase get uploadVideo => UploadVideoUseCase(_repository);

  @injectable
  GetShortUrlUseCase get getShortUrl => GetShortUrlUseCase(_repository);
}
