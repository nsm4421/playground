import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/util/util.dart';
import '../../../../domain/entity/meeting/meeting.dart';
import '../../../../domain/entity/registration/registration.dart';
import '../../../../domain/usecase/registration/usecase.dart';

part 'display_registration.event.dart';

class DisplayRegistrationBloc extends Bloc<DisplayRegistrationsEvent,
    CustomDisplayState<RegistrationEntity>> {
  final MeetingEntity _meeting;
  final RegistrationUseCase _useCase;

  DisplayRegistrationBloc(@factoryParam MeetingEntity meeting,
      {required RegistrationUseCase useCase})
      : _meeting = meeting,
        _useCase = useCase,
        super(CustomDisplayState<RegistrationEntity>()) {
    on<InitDisplayRegistrationEvent>(_onInit);
    on<FetchRegistrationsEvent>(_onFetch);
  }

  MeetingEntity get meeting => _meeting;

  String get _meetingId => _meeting.id!;

  Future<void> _onInit(InitDisplayRegistrationEvent event,
      Emitter<CustomDisplayState<RegistrationEntity>> emit) async {
    emit(state.copyWith(
        status: event.status,
        data: event.registrations,
        errorMessage: event.errorMessage));
  }

  Future<void> _onFetch(DisplayRegistrationsEvent event,
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
