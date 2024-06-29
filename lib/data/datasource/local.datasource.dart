import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import 'chat/impl/private_chat_message.local_datasource_impl.dart';

@module
abstract class LocalDataSource {
  final _logger = Logger();

  @lazySingleton
  LocalPrivateChatMessageDataSource get privateChatMessage =>
      LocalPrivateChatMessageDataSourceImpl(_logger);
}
