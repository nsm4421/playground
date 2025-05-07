import 'dart:io';

import 'package:path/path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/util/logger/logger.dart';
import 'package:uuid/uuid.dart';

part 'datasource_impl.dart';

abstract interface class StorageDataSource {
  Future<String> uploadAvatarAndReturnPublicUrl(File profileImage);

  Future<Iterable<String>> uploadFeedImagesAndReturnPublicUrls(
      List<File> images);

  Future<String> uploadReelsAndReturnPublicUrl(File video);
}
