part of "short.bloc.dart";

@immutable
sealed class ShortEvent {}

final class FetchShortEvent extends ShortEvent {
  final DateTime? afterAt;
  final int? take;

  FetchShortEvent({this.afterAt, this.take});
}
