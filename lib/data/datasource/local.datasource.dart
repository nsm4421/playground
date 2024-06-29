import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import 'chat/private_chat_message/impl/local_private_chat_message.datasource_impl.dart';

@module
abstract class LocalDataSource {
  final _logger = Logger();

  @lazySingleton
  LocalPrivateChatMessageDataSource get privateChatMessage =>
      LocalPrivateChatMessageDataSourceImpl(_logger);
}
