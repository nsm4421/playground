/// Message Event
/// Events below extends MessageEvent
/// ⓐ SubscribeEvent
/// ⓑ MessageReceived
/// ⓒ MessageSent

import 'package:chat/chat.dart';
import 'package:equatable/equatable.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  factory MessageEvent.onSubscribed(User user) => SubscribeEvent(user);

  factory MessageEvent.onMessageReceived(Message message) =>
      MessageReceivedEvent(message);

  factory MessageEvent.onMessageSent(Message message) =>
      MessageSentEvent(message);

  @override
  List<Object> get props => [];
}

class SubscribeEvent extends MessageEvent {
  final User user;

  const SubscribeEvent(this.user);

  @override
  List<Object> get props => [user];
}

class MessageReceivedEvent extends MessageEvent {
  final Message message;

  const MessageReceivedEvent(this.message);

  @override
  List<Object> get props => [message];
}

class MessageSentEvent extends MessageEvent {
  final Message message;

  const MessageSentEvent(this.message);

  @override
  List<Object> get props => [message];
}
