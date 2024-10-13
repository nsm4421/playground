import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constant/constant.dart';
import '../../../domain/entity/meeting/meeting.dart';

part 'edit_meeting.freezed.dart';

part 'edit_meeting.g.dart';

@freezed
class EditMeetingModel with _$EditMeetingModel {
  const factory EditMeetingModel({
    // 여행 장소
    @Default('') String country,
    String? city,
    // 여행 일정
    @Default('') String start_date,
    @Default('') String end_date,
    // 같이 여행할 사람
    int? head_count,
    @Default(TravelPeopleSexType.all) TravelPeopleSexType sex,
    @Default(TravelPreferenceType.all) TravelPreferenceType preference,
    // 여행 경비
    @Default(0) int min_cost,
    @Default(0) int max_cost,
    // 게시글
    @Default('') String title,
    @Default('') String content,
    @Default(<String>[]) List<String> hashtags,
    @Default(<String>[]) List<String> images,
  }) = _EditMeetingModel;

  factory EditMeetingModel.fromJson(Map<String, dynamic> json) =>
      _$EditMeetingModelFromJson(json);

  factory EditMeetingModel.from(MeetingEntity entity) => EditMeetingModel(
      country: entity.country ?? '',
      city: entity.city,
      start_date: entity.startDate!.toUtc().toIso8601String(),
      end_date: entity.endDate!.toUtc().toIso8601String(),
      head_count: entity.headCount,
      sex: entity.sex ?? TravelPeopleSexType.all,
      preference: entity.preference ?? TravelPreferenceType.all,
      min_cost: entity.minCost ?? 0,
      max_cost: entity.maxCost ?? 500,
      title: entity.title ?? '',
      content: entity.content ?? '',
      hashtags: entity.hashtags,
      images: entity.images);
}
