import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/util/logger/logger.dart';
import 'package:travel/data/model/emotion/delete.dart';
import 'package:travel/data/model/emotion/edit.dart';

part 'datasource_impl.dart';

abstract interface class EmotionDataSource {
  Future<void> edit(EditEmotionDto dto);

  Future<void> delete(DeleteEmotionDto dto);
}
