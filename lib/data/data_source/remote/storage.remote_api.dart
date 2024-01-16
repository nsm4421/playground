import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../base/storage.api.dart';

class RemoteStorageApi extends StorageApi {
  final SupabaseStorageClient _storage;

  RemoteStorageApi(this._storage);

  @override
  Future<String> uploadFile(
      {required File file,
      required String bucketName,
      required String dir,
      required String filename,
      bool upsert = false,
      String? contentType,
      int? retryAttempts = 1}) async {
    final path = '$dir/$filename';
    final bucket = _storage.from(bucketName);

    // upload file on storage
    await bucket.upload(path, file,
        retryAttempts: retryAttempts,
        fileOptions: FileOptions(
            cacheControl: '3600', upsert: upsert, contentType: contentType));

    // return download link
    return bucket.getPublicUrl(path);
  }
}
