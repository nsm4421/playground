import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/core/util/util.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constant/constant.dart';

part 'datsource_impl.dart';

abstract interface class LikeDataSource {
  Future<void> create({required Tables refTable, required String refId});

  Future<void> delete({required Tables refTable, required String refId});

  Future<void> deleteById(String likeId);
}
