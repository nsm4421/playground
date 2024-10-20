import 'dart:async';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:travel/core/util/util.dart';
import 'package:travel/domain/usecase/meeting/usecase.dart';

import '../../../../core/constant/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_meeting.state.dart';

class CreateMeetingCubit extends Cubit<CreateMeetingState> {
  CreateMeetingCubit(this._useCase) : super(CreateMeetingState());

  final MeetingUseCase _useCase;

  void updateState(
      {Status? status,
      String? country,
      DateTime? startDate,
      DateTime? endDate,
      bool? isDateSelected,
      int? headCount,
      AccompanySexType? sex,
      TravelThemeType? theme,
      int? minCost,
      int? maxCost,
      String? title,
      String? content,
      List<String>? hashtags,
      String? errorMessage}) {
    emit(CreateMeetingState(
        status: status ?? state.status,
        country: country ?? state.country,
        startDate: startDate ?? state.startDate,
        endDate: endDate ?? state.endDate,
        isDateSelected: isDateSelected ?? state.isDateSelected,
        headCount: headCount ?? state.headCount,
        sex: sex ?? state.sex,
        theme: theme ?? state.theme,
        minCost: minCost ?? state.minCost,
        maxCost: maxCost ?? state.maxCost,
        title: title ?? state.title,
        content: content ?? state.content,
        hashtags: hashtags ?? state.hashtags,
        thumbnail: state.thumbnail,
        errorMessage: errorMessage ?? state.errorMessage));
  }

  void updateThumbnail(File? thumbnail) {
    emit(CreateMeetingState(
        status: state.status,
        country: state.country,
        startDate: state.startDate,
        endDate: state.endDate,
        isDateSelected: state.isDateSelected,
        headCount: state.headCount,
        sex: state.sex,
        theme: state.theme,
        minCost: state.minCost,
        maxCost: state.maxCost,
        title: state.title,
        content: state.content,
        hashtags: state.hashtags,
        thumbnail: thumbnail));
  }

  void submit() async {
    try {
      // validate
      if (state.country.isEmpty) {
        updateState(
            status: Status.error, errorMessage: 'need to select country!');
        return;
      } else if (!state.isDateSelected) {
        updateState(status: Status.error, errorMessage: 'need to select date!');
        return;
      } else if (state.title.isEmpty || state.content.isEmpty) {
        updateState(
            status: Status.error,
            errorMessage: 'need to press title and content');
        return;
      }
      updateState(status: Status.loading);
      await _useCase.create
          .call(
              country: state.country,
              startDate: state.startDate,
              endDate: state.endDate,
              sex: state.sex,
              theme: state.theme,
              title: state.title,
              content: state.content,
              hashtags: state.hashtags,
              thumbnail: state.thumbnail)
          .fold(
              (l) => updateState(status: Status.error, errorMessage: l.message),
              (r) => Timer(const Duration(seconds: 1), () {
                    updateState(status: Status.success);
                  }));
    } catch (error) {
      updateState(status: Status.error, errorMessage: 'unknown error occurs');
      customUtil.logger.e(error);
    }
  }
}
