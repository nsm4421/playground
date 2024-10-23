import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/bloc/display_bloc.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/util/util.dart';
import '../../../../domain/entity/meeting/meeting.dart';
import '../../../../domain/entity/registration/registration.dart';
import '../../../../domain/usecase/registration/usecase.dart';

class DisplayRegistrationBloc extends CustomDisplayBloc<RegistrationEntity> {
  final MeetingEntity _meeting;
  final RegistrationUseCase _useCase;

  DisplayRegistrationBloc(@factoryParam this._meeting,
      {required RegistrationUseCase useCase})
      : _useCase = useCase;

  MeetingEntity get meeting => _meeting;

  String get _meetingId => _meeting.id!;

  @override
  Future<void> onFetch(FetchEvent<RegistrationEntity> event,
      Emitter<CustomDisplayState<RegistrationEntity>> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase.fetch(_meetingId).then((res) => res.fold((l) {
            emit(state.copyWith(status: Status.error, errorMessage: l.message));
          }, (r) {
            emit(state.copyWith(
                status: Status.success, data: r, errorMessage: ''));
          }));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: 'error occurs on fetching data'));
      customUtil.logger.e(error);
    }
  }
}
