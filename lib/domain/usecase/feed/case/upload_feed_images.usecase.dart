import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.constant.dart';
import '../../../repository/feed/feed.repository.dart';

class UploadFeedImagesUseCase {
  final FeedRepository _repository;

  UploadFeedImagesUseCase(this._repository);

  Future<Either<Failure, List<String>>> call(
      {required String feedId, required List<File> images}) async {
    return await _repository.uploadFeedImagesAndReturnDownloadLinks(
        feedId: feedId, images: images);
  }
}
