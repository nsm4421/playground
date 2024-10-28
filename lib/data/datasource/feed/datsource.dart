import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/core/util/util.dart';

import '../../../core/constant/constant.dart';
import '../../model/feed/edit_feed.dart';
import '../../model/feed/fetch_feed.dart';

part 'datasource_impl.dart';

part 'mock_datasource.dart';

abstract interface class FeedDataSource {
  Future<Iterable<FetchFeedModel>> fetch(String beforeAt, {int take = 20});

  Future<void> edit(EditFeedModel model, {bool update = false});

  Future<void> deleteById(String id);
}
