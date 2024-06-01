import 'dart:io';

import 'package:my_app/domain/model/short/short.model.dart';

abstract interface class ShortDataSource {}

abstract interface class LocalShortDataSource implements ShortDataSource {}

abstract interface class RemoteShortDataSource implements ShortDataSource {
  Future<void> saveShort(ShortModel model);

  Future<void> saveVideo({required id, required File video});

  Future<String> getShortDownloadUrl(String id);
}
