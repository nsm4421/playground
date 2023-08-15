/// TypingNotification Event
/// Events below extends TypingNotificationEvent
/// ⓐ SubscribeEvent
/// ⓑ TypingNotificationReceived
/// ⓒ TypingNotificationSent

import 'package:chat/chat.dart';
import 'package:equatable/equatable.dart';

abstract class TypingNotificationEvent extends Equatable {
  const TypingNotificationEvent();

  factory TypingNotificationEvent.onSubscribed(User user,
          {List<String> userWithChat}) =>
      SubscribeEvent(user, userWithChat: userWithChat);

  factory TypingNotificationEvent.onTypingNotificationSent(
          TypingEvent typing) =>
      TypingNotificationSentEvent(typing);

  @override
  List<Object> get props => [];
}

class SubscribeEvent extends TypingNotificationEvent {
  final User user;
  final List<String> userWithChat;

  const SubscribeEvent(this.user, {this.userWithChat});

  @override
  List<Object> get props => [user];
}

class NotSubscribeEvent extends TypingNotificationEvent {}

class TypingNotificationReceivedEvent extends TypingNotificationEvent {
  final TypingEvent typing;

  const TypingNotificationReceivedEvent(this.typing);

  @override
  List<Object> get props => [typing];
}

class TypingNotificationSentEvent extends TypingNotificationEvent {
  final TypingEvent typing;

  const TypingNotificationSentEvent(this.typing);

  @override
  List<Object> get props => [typing];
}
