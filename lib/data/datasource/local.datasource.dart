import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:my_app/core/constant/database.constant.dart';
import 'chat/private_chat_message/private_chat_message.datasource_impl.dart';

@module
abstract class LocalDataSource {
  final _logger = Logger();

  @lazySingleton
  LocalPrivateChatMessageDataSource get privateChatMessage =>
      LocalPrivateChatMessageDataSourceImpl(
          boxName: BoxName.privateChat.name, logger: _logger);
}
