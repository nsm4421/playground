import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/util/util.dart';
import '../../../../domain/entity/meeting/meeting.dart';
import '../../../../domain/usecase/registration/usecase.dart';

part 'edit_registration.state.dart';

part 'edit_registration.event.dart';

class EditRegistrationBloc
    extends Bloc<EditRegistrationEvent, EditRegistrationState> {
  final MeetingEntity _meeting;
  final RegistrationUseCase _useCase;

  EditRegistrationBloc(@factoryParam MeetingEntity meeting,
      {required RegistrationUseCase useCase})
      : _meeting = meeting,
        _useCase = useCase,
        super(EditRegistrationState(meeting)) {
    on<InitEditRegistrationEvent>(_onInit);
    on<RegisterMeetingEvent>(_onRegister);
    on<DeleteRegistrationEvent>(_onDelete);
    on<PermitRegistrationEvent>(_onPermit);
    on<CancelPermitRegistrationEvent>(_onCancelPermit);
  }

  MeetingEntity get meeting => _meeting;

  String get _meetingId => _meeting.id!;

  Future<void> _onInit(InitEditRegistrationEvent event,
      Emitter<EditRegistrationState> emit) async {
    emit(
        state.copyWith(status: event.status, errorMessage: event.errorMessage));
  }

  Future<void> _onRegister(
      RegisterMeetingEvent event, Emitter<EditRegistrationState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase
          .register(meetingId: _meetingId, introduce: event.introduce)
          .then((res) => res.fold((l) {
                emit(state.copyWith(
                    status: Status.error, errorMessage: l.message));
              }, (r) {
                emit(state.copyWith(status: Status.success, errorMessage: ''));
              }));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error,
          errorMessage: 'error occurs on submit registration'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onDelete(DeleteRegistrationEvent event,
      Emitter<EditRegistrationState> emit) async {
    try {
      customUtil.logger.t('delete registration request');
      emit(state.copyWith(status: Status.loading));
      await _useCase.delete(_meetingId).then((res) => res.fold((l) {
            emit(state.copyWith(status: Status.error, errorMessage: l.message));
          }, (r) {
            emit(state.copyWith(status: Status.success, errorMessage: ''));
          }));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: 'error occurs on cancel'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onPermit(PermitRegistrationEvent event,
      Emitter<EditRegistrationState> emit) async {
    try {
      customUtil.logger.t('permit registration request');
      emit(state.copyWith(status: Status.loading));
      await _useCase.permit(event.registrationId).then((res) => res.fold((l) {
            emit(state.copyWith(status: Status.error, errorMessage: l.message));
          }, (r) {
            emit(state.copyWith(status: Status.success, errorMessage: ''));
          }));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: 'error occurs on cancel'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onCancelPermit(CancelPermitRegistrationEvent event,
      Emitter<EditRegistrationState> emit) async {
    try {
      customUtil.logger.t('cancel permit registration request');
      emit(state.copyWith(status: Status.loading));
      await _useCase.cancelPermit(event.registrationId).then((res) =>
          res.fold((l) {
            emit(state.copyWith(status: Status.error, errorMessage: l.message));
          }, (r) {
            emit(state.copyWith(status: Status.success, errorMessage: ''));
          }));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: 'error occurs on cancel'));
      customUtil.logger.e(error);
    }
  }
}
