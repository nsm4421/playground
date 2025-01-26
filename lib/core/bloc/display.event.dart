part of '../export.core.dart';

final class DisplayEvent {}

/// 반드시 구현해야 하는 이벤트
final class InitDisplayEvent extends DisplayEvent {
  final Status? status;
  final String? message;

  InitDisplayEvent({this.status, this.message});
}

final class MountEvent extends DisplayEvent {
  final int? pageSize;

  MountEvent({this.pageSize = 20});
}

final class FetchEvent extends DisplayEvent {}

/// 필요한 경우만 구현해도 되는 이벤트
final class UpdateDisplayDataEvent<T> extends DisplayEvent {
  final List<T> data;

  UpdateDisplayDataEvent(this.data);
}

final class InsertDisplayDataEvent<T> extends DisplayEvent {
  final List<T> data;

  InsertDisplayDataEvent(this.data);
}
