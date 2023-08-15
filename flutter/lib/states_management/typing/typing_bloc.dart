import 'dart:async';
import 'package:chat/chat.dart';
import 'package:bloc/bloc.dart';

import 'typing_event.dart';
import 'typing_state.dart';

class TypingBloc
    extends Bloc<TypingNotificationEvent, TypingNotificationState> {
  final ITypingNotificationService _typingNotificationService;
  StreamSubscription _subscription;

  TypingBloc(this._typingNotificationService)
      : super(TypingNotificationState.initial());

  @override
  Stream<TypingNotificationState> mapEventToState(
      TypingNotificationEvent event) async* {
    /// Subscribe but not user
    if (event is SubscribeEvent && event.userWithChat == null) {
      add(NotSubscribeEvent());
      return;
    }

    /// Subscribe
    if (event is SubscribeEvent) {
      await _subscription?.cancel();
      _subscription = _typingNotificationService
          .subscribe(event.user, event.userWithChat)
          .listen((typing) => add(TypingNotificationReceivedEvent(typing)));
    }

    /// Received
    if (event is TypingNotificationReceivedEvent) {
      yield TypingNotificationState.received(event.typing);
    }

    /// Send
    if (event is TypingNotificationSentEvent) {
      await _typingNotificationService.send(event: event.typing);
      yield TypingNotificationState.sent();
    }

    /// Not Subscribe
    if (event is NotSubscribeEvent) {
      yield TypingNotificationState.initial();
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _typingNotificationService.dispose();
    return super.close();
  }
}
