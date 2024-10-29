import '../../domain/entity/feed/feed.dart';
import '../../domain/entity/meeting/meeting.dart';
import '../constant/constant.dart';

mixin class DomainUtil {
  Tables getRefTable(BaseEntity entity) {
    if (entity is MeetingEntity) {
      return Tables.meeting;
    } else if (entity is FeedEntity) {
      return Tables.feeds;
    } else {
      throw Exception('ref table is not well defined');
    }
  }
}
