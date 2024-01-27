import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:rethink_db_ns/rethink_db_ns.dart';

import '../../model/typing_event_model.dart';
import '../../model/user_model.dart';
import 'typing_notification_service_interface.dart';

class TypingNotificationService implements ITypingNotificationService {
  final _logger = Logger();
  final RethinkDb _db;
  final Connection _connection;
  final _controller = StreamController<TypingEvent>.broadcast();
  StreamSubscription _changeFeed;

  TypingNotificationService(this._db, this._connection);

  @override
  Future<bool> send({@required TypingEvent event, @required User to}) async {
    if (to.active) return false;
    Map record = await _db
        .table('typing_events')
        .insert(event.toJson(), {'conflict': 'update'}).run(_connection);
    return record['inserted'] == 1;
  }

  @override
  Stream<TypingEvent> subscribe(User user, List<String> userIds) {
    _startReceivingTypingEvent(user, userIds);
    return _controller.stream;
  }

  @override
  void dispose() {
    _changeFeed?.cancel();
    _controller?.close();
  }

  _startReceivingTypingEvent(User user, List<String> userIds) {
    _changeFeed = _db
        .table('typing_events')
        .filter((event) {
          return event('to')
              .eq(user.id)
              .and(_db.expr(userIds).contains(event('from')));
        })
        .changes({'include_initial': true})
        .run(_connection)
        .asStream()
        .cast<Feed>()
        .listen((event) {
          event
              .forEach((feedData) {
                if (feedData['new_val'] == null) return;

                final typingEvent = _typingEventFromFeed(feedData);
                _controller.sink.add(typingEvent);
                _removeDeliveredTypingEvent(typingEvent);
              })
              // logging error
              .catchError((err) => _logger.e(err))
              .onError((err, stackTrace) => _logger.e(err));
        });
  }

  TypingEvent _typingEventFromFeed(feedData) =>
      TypingEvent.fromJson(feedData['new_val']);

  _removeDeliveredTypingEvent(TypingEvent event) {
    _db
        .table('typing_events')
        .get(event.id)
        .delete({'return_changes': false}).run(_connection);
  }
}
