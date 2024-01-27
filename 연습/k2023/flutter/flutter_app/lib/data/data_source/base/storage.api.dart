import 'dart:io';

abstract class StorageApi {
  Future<String> uploadFile({
    required File file,
    required String bucketName,
    required String dir,
    required String filename,
    bool upsert = false,
    String? contentType,
    int? retryAttempts = 1,
  });
}
