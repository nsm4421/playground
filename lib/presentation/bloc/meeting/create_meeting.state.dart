import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel/core/util/util.dart';

import '../../../core/constant/constant.dart';

part 'create_meeting.state.freezed.dart';

@freezed
class CreateMeetingState with _$CreateMeetingState {
  const factory CreateMeetingState({
    @Default(Status.initial) Status status,
    @Default('') String country,
    @Default('') String city,
    DateTime? startDate,
    DateTime? endDate,
    @Default(2) int headCount,
    @Default(TravelPeopleSexType.all) TravelPeopleSexType sex,
    @Default(TravelPreferenceType.all) TravelPreferenceType preference,
    @Default(10) int minCost,
    @Default(500) int maxCost,
    @Default('') String title,
    @Default('') String content,
    @Default(<String>[]) List<String> hashtags,
    @Default(<File>[]) List<File> images,
  }) = _CreateMeetingState;
}
