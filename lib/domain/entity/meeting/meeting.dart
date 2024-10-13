import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel/data/model/meeting/fetch_meetings.dart';
import 'package:travel/domain/entity/auth/presence.dart';

import '../../../core/constant/constant.dart';

part 'meeting.freezed.dart';

@freezed
class MeetingEntity with _$MeetingEntity {
  const factory MeetingEntity({
    // 여행 장소
    String? country,
    String? city,
    // 여행 일정
    DateTime? startDate,
    DateTime? endDate,
    // 같이 여행할 사람
    int? headCount,
    TravelPeopleSexType? sex,
    TravelPreferenceType? preference,
    // 여행 경비
    int? minCost,
    int? maxCost,
    // 게시글
    String? title,
    String? content,
    @Default(<String>[]) List<String> hashtags,
    @Default(<String>[]) List<String> images,
    // 메타정보
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    PresenceEntity? author,
  }) = _MeetingEntity;

  factory MeetingEntity.from(FetchMeetingsModel model) => MeetingEntity(
      country: model.country.isNotEmpty ? model.country : null,
      city: model.city,
      startDate: DateTime.tryParse(model.start_date),
      endDate: DateTime.tryParse(model.end_date),
      headCount: model.head_count,
      sex: model.sex,
      preference: model.preference,
      minCost: model.min_cost,
      maxCost: model.max_cost,
      title: model.title.isNotEmpty ? model.title : null,
      content: model.content.isNotEmpty ? model.content : null,
      hashtags: model.hashtags,
      images: model.images,
      id: model.id.isNotEmpty ? model.id : null,
      createdAt: DateTime.tryParse(model.created_at),
      updatedAt: DateTime.tryParse(model.updated_at),
      author: PresenceEntity(
        uid: model.author_uid,
        username: model.author_username,
        avatarUrl: model.author_avatar_url,
      ));
}
