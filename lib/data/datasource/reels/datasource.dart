import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constant/constant.dart';
import '../../../core/util/util.dart';
import '../../model/reels/edit_reels.dart';
import '../../model/reels/fetch_reels.dart';

part 'datasource_impl.dart';

abstract interface class ReelsDataSource {
  Future<Iterable<FetchReelsModel>> fetch(String beforeAt, {int take = 20});

  Future<void> edit(EditReelsModel model, {bool update = false});
}
