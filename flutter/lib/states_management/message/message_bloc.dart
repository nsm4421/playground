import 'dart:async';
import 'package:chat/chat.dart';
import 'package:bloc/bloc.dart';

import 'message_event.dart';
import 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final IMessageService _messageService;
  StreamSubscription _subscription;

  MessageBloc(this._messageService) : super(MessageState.initial());

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    /// subscribe
    if (event is SubscribeEvent) {
      await _subscription?.cancel();
      _subscription = _messageService.messages(user: event.user).listen((msg) {
        add(MessageReceivedEvent(msg));
      });
    }

    /// receive
    if (event is MessageReceivedEvent) {
      yield MessageState.received(event.message);
    }

    /// send
    if (event is MessageSentEvent) {
      await _messageService.send(event.message);
      yield MessageState.sent(event.message);
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _messageService.dispose();
    return super.close();
  }
}
