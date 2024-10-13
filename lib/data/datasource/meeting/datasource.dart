import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/core/util/util.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constant/constant.dart';
import '../../model/meeting/edit_meeting.dart';
import '../../model/meeting/fetch_meetings.dart';

part 'datasource_impl.dart';

abstract interface class MeetingDataSource {
  Future<Iterable<FetchMeetingsModel>> fetch(String beforeAt, {int take = 20});

  Future<void> create(EditMeetingModel model);

  Future<void> modify({required String id, required EditMeetingModel model});

  Future<void> deleteById(String id);
}
