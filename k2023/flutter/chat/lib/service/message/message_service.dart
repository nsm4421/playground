import 'dart:async';

import 'package:logger/logger.dart';
import 'package:rethink_db_ns/rethink_db_ns.dart';

import '../../model/message_model.dart';
import '../../model/user_model.dart';
import '../encryption/encryption_service.dart';
import 'message_service_interface.dart';

class MessageService implements IMessageService {
  final Connection _connection;
  final RethinkDb _db;
  final EncryptionService _encryption;

  final _logger = Logger();

  final _controller = StreamController<Message>.broadcast();
  StreamSubscription _changeFeed;

  MessageService(this._db, this._connection, this._encryption);

  @override
  dispose() {
    _changeFeed?.cancel();
    _controller?.close();
  }

  @override
  Stream<Message> messages({User user}) {
    _startReceivingMessages(user);
    return _controller.stream;
  }

  @override
  Future<bool> send(Message message) async {
    // encrypt content of message
    var data = message.toJson();
    data['contents'] = _encryption.encrypt(message.contents);
    // insert data into database
    Map record = await _db.table('messages').insert(data).run(_connection);
    // return whether data inserted successfully or not
    return record['inserted'] == 1;
  }

  _startReceivingMessages(User user) {
    _changeFeed = _db
        .table('messages')
        .filter({'to': user.id})
        .changes({'include_initial': true})
        .run(_connection)
        .asStream()
        .cast<Feed>()
        .listen((event) {
          event
              .forEach((feedData) {
                if (feedData['new_val'] == null) return;

                final message = _messageFromFeed(feedData);
                _controller.sink.add(message);
                _removeDeliveredMessage(message);
              })
              // logging error
              .catchError((err) => _logger.e(err))
              .onError((err, stackTrace) => _logger.e(err));
        });
  }

  Message _messageFromFeed(feedData) {
    // decrypt content of message
    var data = feedData['new_val'];
    data['contents'] = _encryption.decrypt(data['contents']);
    // return message as json
    return Message.fromJson(data);
  }

  _removeDeliveredMessage(Message message) {
    _db
        .table('messages')
        .get(message.id)
        .delete({'return_changes': false}).run(_connection);
  }
}
