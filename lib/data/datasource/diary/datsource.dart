import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/core/util/util.dart';
import 'package:travel/data/model/diary/edit_diary.dart';
import 'package:travel/data/model/diary/fetch_diary.dart';

part 'datasource_impl.dart';

part 'mock_datasource.dart';

abstract interface class DiaryDataSource {
  Future<Iterable<FetchDiaryModel>> fetch(String beforeAt, {int take = 20});

  Future<void> edit(EditDiaryModel model, {bool update = false});

  Future<void> deleteById(String id);
}
