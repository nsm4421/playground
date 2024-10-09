import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:travel/core/response/error_response.dart';
import 'package:travel/data/datasource/diary/datsource.dart';

import '../../../core/constant/constant.dart';
import '../../../core/util/util.dart';
import '../../../data/datasource/storage/datasource.dart';
import '../../../data/model/diary/edit_diary.dart';
import '../../entity/diary/diary.dart';

part 'repository_impl.dart';

abstract interface class DiaryRepository {
  Future<Either<ErrorResponse, List<DiaryEntity>>> fetch(String beforeAt,
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
