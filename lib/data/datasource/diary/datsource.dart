import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/core/util/util.dart';
import 'package:travel/data/model/diary/edit_diary.dart';

part 'datasource_impl.dart';

abstract interface class DiaryDataSource {
  Future<void> edit(EditDiaryModel model, {bool update = false});

  Future<void> deleteById(String id);
}
