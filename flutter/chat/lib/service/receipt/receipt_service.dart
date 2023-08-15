import 'dart:async';

import 'package:logger/logger.dart';
import 'package:rethink_db_ns/rethink_db_ns.dart';

import '../../model/receipt_model.dart';
import '../../model/user_model.dart';
import 'receipt_service_interface.dart';

class ReceiptService implements IReceiptService {
  final RethinkDb _db;
  final Connection _connection;
  final _logger = Logger();

  final _controller = StreamController<Receipt>.broadcast();
  StreamSubscription _changeFeed;

  ReceiptService(this._db, this._connection);

  @override
  dispose() {
    _changeFeed?.cancel();
    _controller?.close();
  }

  @override
  Stream<Receipt> receipts(User user) {
    _startReceivingReceipts(user);
    return _controller.stream;
  }

  @override
  Future<bool> send(Receipt receipt) async {
    Map record =
        await _db.table('receipts').insert(receipt.toJson()).run(_connection);
    return record['inserted'] == 1;
  }

  _startReceivingReceipts(User user) {
    _changeFeed = _db
        .table('receipts')
        .filter({'recipient': user.id})
        .changes({'include_initial': true})
        .run(_connection)
        .asStream()
        .cast<Feed>()
        .listen((event) {
          event
              .forEach((feedData) {
                if (feedData['new_val'] == null) return;

                final receipt = _receiptFromFeed(feedData);
                _controller.sink.add(receipt);
                _removeDeliveredReceipt(receipt);
              })
              .catchError((err) => _logger.e(err))
              .onError((err, stackTrace) => _logger.e(err));
        });
  }

  Receipt _receiptFromFeed(feedData) => Receipt.fromJson(feedData['new_val']);

  _removeDeliveredReceipt(Receipt receipt) {
    _db
        .table('receipts')
        .get(receipt.id)
        .delete({'return_changes': false}).run(_connection);
  }
}
