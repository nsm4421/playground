import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/response/error_response.dart';
import '../../../../core/util/util.dart';
import '../../../../domain/entity/auth/presence.dart';
import '../../../../domain/entity/meeting/meeting.dart';
import '../../../../domain/entity/registration/registration.dart';
import '../../../../domain/usecase/registration/usecase.dart';

part 'registration.state.dart';

part 'registration.event.dart';

class EditRegistrationBloc
    extends Bloc<EditRegistrationEvent, EditRegistrationState> {
  final MeetingEntity _meeting;
  final RegistrationUseCase _useCase;

  EditRegistrationBloc(@factoryParam MeetingEntity meeting,
      {required RegistrationUseCase useCase})
      : _meeting = meeting,
        _useCase = useCase,
        super(EditRegistrationState(meeting)) {
    on<InitialRegistrationEvent>(_onInit);
    on<FetchRegistrationEvent>(_onFetch);
    on<RegisterMeetingEvent>(_onRegister);
    on<CancelRegistrationEvent>(_onCancel);
  }

  MeetingEntity get meeting => _meeting;

  String get _meetingId => _meeting.id!;

  Future<void> _onInit(InitialRegistrationEvent event,
      Emitter<EditRegistrationState> emit) async {
    emit(state.copyWith(
        status: event.status,
        registrations: event.registrations,
        errorMessage: event.errorMessage));
  }

  Future<void> _onFetch(
      EditRegistrationEvent event, Emitter<EditRegistrationState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _$fetch((l) {
        emit(state.copyWith(status: Status.error, errorMessage: l.message));
      }, (r) {
        emit(state.copyWith(status: Status.success, errorMessage: null));
      });
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: 'error occurs on fetching data'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onRegister(
      RegisterMeetingEvent event, Emitter<EditRegistrationState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase
          .register(meetingId: _meetingId, introduce: event.introduce)
          .then((res) => res.mapLeft((l) {
                emit(state.copyWith(
                    status: Status.error, errorMessage: l.message));
              }).mapAsync((r) async {
                await _$fetch((l) {
                  emit(state.copyWith(
                      status: Status.error, errorMessage: l.message));
                }, (r) {
                  emit(state.copyWith(
                      status: Status.success, errorMessage: null));
                });
              }));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: 'error occurs on register'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onCancel(CancelRegistrationEvent event,
      Emitter<EditRegistrationState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase.cancel(_meetingId).then((res) => res.mapLeft((l) {
            emit(state.copyWith(status: Status.error, errorMessage: l.message));
          }).mapAsync((r) async {
            await _$fetch((l) {
              emit(state.copyWith(
                  status: Status.error, errorMessage: l.message));
            }, (r) {
              emit(state.copyWith(status: Status.success, errorMessage: null));
            });
          }));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: 'error occurs on cancel'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _$fetch(
    void Function(ErrorResponse error) onError,
    void Function(List<RegistrationEntity> data) onSuccess,
  ) async {
    await _useCase
        .fetch(_meetingId)
        .then((res) => res.fold(onError, onSuccess));
  }
}
