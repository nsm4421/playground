import 'package:travel/core/constant/constant.dart';

import '../../domain/entity/diary/diary.dart';
import '../../domain/entity/meeting/meeting.dart';

mixin class DomainUtil {
  Tables getRefTable(BaseEntity entity) {
    if (entity is MeetingEntity) {
      return Tables.meeting;
    } else if (entity is DiaryEntity) {
      return Tables.diaries;
    } else {
      throw Exception('ref table is not well defined');
    }
  }
}