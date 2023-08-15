import 'package:flutter/cupertino.dart';

import '../../model/typing_event_model.dart';
import '../../model/user_model.dart';

abstract class ITypingNotificationService {
  Future<bool> send({@required TypingEvent event});

  Stream<TypingEvent> subscribe(User user, List<String> userIds);

  void dispose();
}
