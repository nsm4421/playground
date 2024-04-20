import 'package:hot_place/data/data_source/chat/open_chat/message/local_data_source.dart';
import 'package:hot_place/data/data_source/chat/open_chat/message/local_data_source.impl.dart';
import 'package:hot_place/data/data_source/chat/private_chat/message/local_data_source.dart';
import 'package:hot_place/data/data_source/chat/private_chat/message/local_data_source.impl.dart';
import 'package:hot_place/data/data_source/feed/data_source.dart';
import 'package:hot_place/data/data_source/feed/local_data_source.impl.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@module
abstract class LocalDataSourceModule {
  final _logger = Logger();

  @lazySingleton
  LocalFeedDataSource get feed => LocalFeedDataSourceImpl(_logger);

  @lazySingleton
  LocalOpenChatMessageDataSource get openChatMessage =>
      LocalOpenChatMessageDataSourceImpl(_logger);

  @lazySingleton
  LocalPrivateChatMessageDataSource get localChatMessage =>
      LocalPrivateChatMessageDataSourceImpl(_logger);
}
