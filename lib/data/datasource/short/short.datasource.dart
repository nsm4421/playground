import 'dart:io';

import 'package:my_app/domain/model/short/short.model.dart';

abstract interface class ShortDataSource {}

abstract interface class LocalShortDataSource implements ShortDataSource {}

abstract interface class RemoteShortDataSource implements ShortDataSource {
  Stream<Iterable<ShortModel>> getShortStream({String? afterAt, bool? descending});

  Future<Iterable<ShortModel>> getShorts(
      {String? afterAt, int? take, bool? descending});

  Future<void> saveShort(ShortModel model);

  Future<void> saveVideo({required id, required File video});

  Future<String> getShortDownloadUrl(String id);
}
