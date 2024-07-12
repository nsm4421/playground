import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/entity/notification/notification.entity.dart';
import 'package:hot_place/domain/usecase/notification/notification.usecase.dart';
import 'package:injectable/injectable.dart';

part 'notification.state.dart';

part 'notification.event.dart';

@injectable
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationUseCase _useCase;

  Stream<List<NotificationEntity>> get notificationStream =>
      _useCase.getStream.call();

  NotificationBloc(this._useCase) : super(InitialNotificationState()) {
    on<InitNotificationEvent>(_onInit);
    on<DeleteNotificationEvent>(_onDelete);
    on<DeleteAllNotificationsEvent>(_onDeleteAll);
  }

  Future<void> _onInit(
      InitNotificationEvent event, Emitter<NotificationState> emit) async {
    try {
      emit(InitialNotificationState());
    } catch (err) {
      emit(const NotificationFailureState('알림정보를 가져오는데 에러가 발생했습니다'));
      debugPrint(err.toString());
    }
  }

  Future<void> _onDelete(
      DeleteNotificationEvent event, Emitter<NotificationState> emit) async {
    try {
      emit(NotificationLoadingState());
      final res = await _useCase.delete.call(event.notificationId);
      res.fold(
          (l) => emit(
              NotificationFailureState(l.message ?? '알림정보를 삭제하는데 에러가 발생했습니다')),
          (r) => emit(NotificationSuccessState()));
    } catch (err) {
      emit(const NotificationFailureState('알림정보를 삭제하는데 에러가 발생했습니다'));
      debugPrint(err.toString());
    }
  }

  Future<void> _onDeleteAll(DeleteAllNotificationsEvent event,
      Emitter<NotificationState> emit) async {
    try {
      emit(NotificationLoadingState());
      final res = await _useCase.deleteAll.call(event.currentUid);
      res.fold(
          (l) => emit(NotificationFailureState(
              l.message ?? '알림정보 전체 삭제하는데 에러가 발생했습니다')),
          (r) => emit(NotificationSuccessState()));
    } catch (err) {
      emit(const NotificationFailureState('알림정보 전체 삭제하는데 에러가 발생했습니다'));
      debugPrint(err.toString());
    }
  }
}
