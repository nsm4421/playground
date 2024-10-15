import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_meeting.state.dart';

import '../../../core/constant/constant.dart';

class CreateMeetingCubit extends Cubit<CreateMeetingState> {
  CreateMeetingCubit() : super(const CreateMeetingState());

  setCountry(String value) {
    emit(state.copyWith(country: value));
  }

  setDateRange(DateTimeRange value) {
    emit(state.copyWith(dateRange: value));
  }

  setHeadCount(int value) {
    emit(state.copyWith(headCount: value));
  }

  setSex(TravelPeopleSexType value) {
    emit(state.copyWith(sex: value));
  }

  setTheme(TravelThemeType value) {
    emit(state.copyWith(theme: value));
  }

  setCost({int? minCost, int? maxCost}) {
    emit(state.copyWith(
        minCost: minCost ?? state.minCost, maxCost: maxCost ?? state.maxCost));
  }

  setTitle(String value) {
    emit(state.copyWith(title: value));
  }

  setContent(String value) {
    emit(state.copyWith(content: value));
  }

  setHashtags(List<String> value) {
    emit(state.copyWith(hashtags: value));
  }

  setThumbnail(File? value) {
    emit(state.copyWith(thumbnail: value));
  }
}
