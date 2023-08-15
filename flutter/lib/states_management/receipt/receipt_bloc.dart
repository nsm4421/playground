import 'dart:async';
import 'package:chat/chat.dart';
import 'package:bloc/bloc.dart';
import 'package:chat/service/receipt/receipt_service_interface.dart';

import 'receipt_event.dart';
import 'receipt_state.dart';

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  final IReceiptService _receiptService;
  StreamSubscription _subscription;

  ReceiptBloc(this._receiptService) : super(ReceiptState.initial());

  @override
  Stream<ReceiptState> mapEventToState(ReceiptEvent event) async* {
    /// subscribe
    if (event is SubscribeEvent) {
      await _subscription?.cancel();
      _subscription = _receiptService
          .receipts(event.user)
          .listen((receipt) => add(ReceiptReceivedEvent(receipt)));
    }

    /// received
    if (event is ReceiptReceivedEvent) {
      yield ReceiptState.received(event.receipt);
    }

    /// send
    if (event is ReceiptSentEvent) {
      await _receiptService.send(event.receipt);
      yield ReceiptState.sent(event.receipt);
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _receiptService.dispose();
    return super.close();
  }
}
