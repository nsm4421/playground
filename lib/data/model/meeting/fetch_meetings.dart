import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel/domain/entity/meeting/meeting.dart';

import '../../../core/constant/constant.dart';

part 'fetch_meetings.freezed.dart';

part 'fetch_meetings.g.dart';

@freezed
class FetchMeetingsModel with _$FetchMeetingsModel {
  const factory FetchMeetingsModel({
    // 여행 장소
    @Default('') String country,
    String? city,
    // 여행 일정
    @Default('') String start_date,
    @Default('') String end_date,
    // 같이 여행할 사람
    int? head_count,
    @Default(AccompanySexType.all) AccompanySexType sex,
    @Default(TravelThemeType.all) TravelThemeType theme,
    // 여행 경비
    @Default(0) int min_cost,
    @Default(0) int max_cost,
    // 게시글
    @Default('') String title,
    @Default('') String content,
    @Default(<String>[]) List<String> hashtags,
    String? thumbnail,
    // 메타정보
    @Default('') String id,
    @Default('') String created_at,
    @Default('') String updated_at,
    @Default('') String author_uid,
    @Default('') String author_username,
    @Default('') String author_avatar_url,
  }) = _FetchMeetingsModel;

  factory FetchMeetingsModel.fromJson(Map<String, dynamic> json) =>
      _$FetchMeetingsModelFromJson(json);
}
