import 'dart:io';

import '../../../core/enums/bucket_name.enum.dart';

abstract class StorageApi {
  Future<String> uploadFile({
    required File file,
    required BucketName bucketName,
    required String dir,
    required String filename,
    bool upsert = false,
    String? contentType,
    int? retryAttempts = 1,
  });
}
