import 'package:chat/chat.dart';
import 'package:equatable/equatable.dart';

abstract class TypingNotificationState extends Equatable {
  const TypingNotificationState();

  factory TypingNotificationState.initial() => TypingNotificationInitial();

  factory TypingNotificationState.sent() => TypingNotificationSentSuccess();

  factory TypingNotificationState.received(TypingEvent typingEvent) =>
      TypingNotificationReceivedSuccess(typingEvent);

  @override
  List<Object> get props => [];
}

class TypingNotificationInitial extends TypingNotificationState {}

class TypingNotificationSentSuccess extends TypingNotificationState {}

class TypingNotificationReceivedSuccess extends TypingNotificationState {
  final TypingEvent typingEvent;

  const TypingNotificationReceivedSuccess(this.typingEvent);

  @override
  List<Object> get props => [typingEvent];
}
