part of 'notification.bloc.dart';

@immutable
sealed class NotificationState {
  const NotificationState();
}

final class InitialNotificationState extends NotificationState {}

final class NotificationLoadingState extends NotificationState {}

final class NotificationFailureState extends NotificationState {
  final String message;

  const NotificationFailureState(this.message);
}

final class NotificationSuccessState extends NotificationState {}
