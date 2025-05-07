import 'package:flutter/foundation.dart';

import '../../model/message_model.dart';
import '../../model/user_model.dart';

abstract class IMessageService {
  Future<bool> send(Message message);

  Stream<Message> messages({@required User user});

  dispose();
}
