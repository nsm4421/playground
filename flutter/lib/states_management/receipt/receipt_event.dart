/// Receipt Event
/// Events below extends ReceiptEvent
/// ⓐ SubscribeEvent
/// ⓑ ReceiptReceived
/// ⓒ ReceiptSent

import 'package:chat/chat.dart';
import 'package:equatable/equatable.dart';

abstract class ReceiptEvent extends Equatable {
  const ReceiptEvent();

  factory ReceiptEvent.onSubscribed(User user) => SubscribeEvent(user);

  factory ReceiptEvent.onReceiptSent(Receipt receipt) => ReceiptSentEvent(receipt);

  @override
  List<Object> get props => [];
}

class SubscribeEvent extends ReceiptEvent {
  final User user;

  const SubscribeEvent(this.user);

  @override
  List<Object> get props => [user];
}

class ReceiptReceivedEvent extends ReceiptEvent {
  final Receipt receipt;

  const ReceiptReceivedEvent(this.receipt);

  @override
  List<Object> get props => [receipt];
}

class ReceiptSentEvent extends ReceiptEvent {
  final Receipt receipt;

  const ReceiptSentEvent(this.receipt);

  @override
  List<Object> get props => [receipt];
}
