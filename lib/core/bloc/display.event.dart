part of '../export.core.dart';

final class DisplayEvent {}

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
