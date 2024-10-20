import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/util/util.dart';
import '../../../../domain/entity/auth/presence.dart';
import '../../../../domain/entity/meeting/meeting.dart';
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
    on<FetchMeetingEvent>(_onFetch);
    on<RegisterMeetingEvent>(_onRegister);
    on<CancelMeetingEvent>(_onCancel);
  }

  String get _meetingId => _meeting.id!;

  Future<void> _onFetch(
      EditRegistrationEvent event, Emitter<EditRegistrationState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase.fetch(_meetingId).then((res) => res.fold((l) {
            emit(state.copyWith(status: Status.error, errorMessage: l.message));
          }, (r) {
            emit(state.copyWith(
                status: Status.success,
                accompanies: r.map((item) => item.proposer!).toList(),
                errorMessage: null));
          }));
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
      await _useCase.register(_meetingId).then((res) => res.fold((l) {
            emit(state.copyWith(status: Status.error, errorMessage: l.message));
          }, (r) {
            emit(state.copyWith(
                status: Status.success,
                accompanies: [...state.accompanies, event.currentUser],
                errorMessage: null));
          }));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: 'error occurs on register'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onCancel(
      CancelMeetingEvent event, Emitter<EditRegistrationState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase.cancel(_meetingId).then((res) => res.fold((l) {
            emit(state.copyWith(status: Status.error, errorMessage: l.message));
          }, (r) {
            emit(state.copyWith(
                status: Status.success,
                accompanies: state.accompanies
                    .where((item) => item.uid != event.currentUser.uid)
                    .toList(),
                errorMessage: null));
          }));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: 'error occurs on cancel'));
      customUtil.logger.e(error);
    }
  }
}
