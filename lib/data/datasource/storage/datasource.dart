import 'dart:io';

import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/core/util/logger/logger.dart';
import 'package:uuid/uuid.dart';

part 'datasource_impl.dart';

abstract interface class StorageDataSource {
  Future<String> uploadImageAndReturnPublicUrl(
      {required File file,
        required String bucketName,
        String? directory,
        String? filename,
        bool upsert = false});
}