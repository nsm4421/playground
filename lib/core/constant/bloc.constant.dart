part of 'constant.dart';

abstract class BaseState {
  final Status status;
  final String message;

  BaseState({this.status = Status.initial, this.message = ''});

  BaseState copyWith({Status? status, String? message});
}
