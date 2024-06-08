part of "message.bloc.dart";

@immutable
sealed class MessageState {}

final class InitialMessageState extends MessageState {}

final class MessageLoadingState extends MessageState {}

final class MessageSuccessState extends MessageState {}

final class MessageFailureState extends MessageState {
  final String _message;

  MessageFailureState(this._message);
}
