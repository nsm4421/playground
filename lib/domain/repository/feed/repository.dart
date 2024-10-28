import 'dart:io';

import 'package:either_dart/either.dart';

import '../../../core/constant/constant.dart';
import '../../../core/response/error_response.dart';
import '../../../core/util/util.dart';
import '../../../data/datasource/feed/datsource.dart';
import '../../../data/datasource/storage/datasource.dart';
import '../../../data/model/feed/edit_feed.dart';
import '../../entity/feed/feed.dart';

part 'repository_impl.dart';

abstract interface class FeedRepository {
  Future<Either<ErrorResponse, List<FeedEntity>>> fetch(String beforeAt,
      {int take = 20});

  Future<Either<ErrorResponse, void>> edit(
      {required String id,
      String? location,
      required String content,
      required List<String> hashtags,
      required List<File?> images,
      required List<String> captions,
      required bool isPrivate,
      bool update = false});

  Future<Either<ErrorResponse, void>> delete(String id);
}
