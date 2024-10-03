import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:travel/core/response/response_wrapper.dart';
import 'package:travel/data/datasource/auth/datasource.dart';
import 'package:travel/data/datasource/diary/datsource.dart';
import 'package:uuid/uuid.dart';

import '../../../core/util/util.dart';
import '../../../data/datasource/storage/datasource.dart';
import '../../../data/model/diary/edit_diary.dart';

part 'repository_impl.dart';

abstract interface class DiaryRepository {
  Future<ResponseWrapper<void>> edit(
      {required String id,
      String? location,
      required List<String> hashtags,
      required List<File?> images,
      required List<String> captions,
      required bool isPrivate,
      bool update = false});

  Future<ResponseWrapper<void>> delete(String id);
}
