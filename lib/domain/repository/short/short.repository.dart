import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:my_app/core/exception/failure.dart';
import 'package:my_app/data/entity/short/short.entity.dart';

abstract interface class ShortRepository {
  Stream<List<ShortEntity>> get shortStream;

  Future<Either<Failure, List<ShortEntity>>> getShorts(
      {String? afterAt, int? take, bool? descending});

  Future<Either<Failure, void>> saveShort(ShortEntity entity);

  Future<Either<Failure, void>> saveVideo({required id, required File video});

  Future<Either<Failure, String>> getShortDownloadUrl(String id);
}
