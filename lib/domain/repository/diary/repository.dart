import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/core/response/error_response.dart';
import 'package:travel/data/datasource/diary/datsource.dart';

import '../../../core/util/util.dart';
import '../../../data/datasource/storage/datasource.dart';
import '../../../data/model/diary/edit_diary.dart';

part 'repository_impl.dart';

abstract interface class DiaryRepository {
  Future<Either<ErrorResponse, void>> edit(
      {required String id,
      String? location,
      required List<String> hashtags,
      required List<File?> images,
      required List<String> captions,
      required bool isPrivate,
      bool update = false});

  Future<Either<ErrorResponse, void>> delete(String id);
}
