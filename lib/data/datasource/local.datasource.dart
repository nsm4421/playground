import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:my_app/core/constant/database.constant.dart';
import 'package:my_app/domain/model/chat/message/private_chat_message.model.dart';

import '../../domain/model/chat/message/local_private_chat_message.model.dart';
import 'chat/private_chat_message/private_chat_message.datasource_impl.dart';

@module
abstract class LocalDataSource {
  final Box<LocalPrivateChatMessageModel> _privateChatMessageBox =
      Hive.box(BoxName.privateChat.name);
  final _logger = Logger();

  @lazySingleton
  LocalPrivateChatMessageDataSource get privateChatMessage =>
      LocalPrivateChatMessageDataSourceImpl(
          box: _privateChatMessageBox, logger: _logger);
}
