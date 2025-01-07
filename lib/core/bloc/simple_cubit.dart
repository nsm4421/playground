part of '../export.core.dart';

class SimpleBlocState {
  final Status status;
  final String errorMessage;

  SimpleBlocState({this.status = Status.initial, this.errorMessage = ''});

  SimpleBlocState copyWith({Status? status, String? errorMessage}) {
    return SimpleBlocState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}

class SimpleCubit extends Cubit<SimpleBlocState> {
  SimpleCubit() : super(SimpleBlocState());

  void updateStatus({Status? status, String? errorMessage}) {
    emit(state.copyWith(
      status: status,
      errorMessage: errorMessage,
    ));
  }
}
