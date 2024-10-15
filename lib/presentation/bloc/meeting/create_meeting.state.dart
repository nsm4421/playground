import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constant/constant.dart';

part 'create_meeting.state.freezed.dart';

@freezed
class CreateMeetingState with _$CreateMeetingState {
  const factory CreateMeetingState({
    @Default(Status.initial) Status status,
    @Default('') String country,
    DateTimeRange? dateRange,
    @Default(2) int headCount,
    @Default(TravelPeopleSexType.all) TravelPeopleSexType sex,
    @Default(TravelThemeType.all) TravelThemeType theme,
    @Default(10) int minCost,
    @Default(500) int maxCost,
    @Default('') String title,
    @Default('') String content,
    @Default(<String>[]) List<String> hashtags,
    File? thumbnail,
  }) = _CreateMeetingState;
}
