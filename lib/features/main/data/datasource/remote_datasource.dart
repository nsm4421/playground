import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:logger/logger.dart';

import '../../../auth/data/datasource/auth.datasource.dart';
import '../../../chat/data/datasource/open_chat/open_chat.datasource_impl.dart';
import '../../../chat/data/datasource/open_chat_message/open_chat_message.datasource_impl.dart';
import '../../../chat/data/datasource/private_chat_message/private_chat_message.datasource_impl.dart';

@module
abstract class RemoteDataSource {
  final _dio = Dio();
  final _client = Supabase.instance.client;
  final _logger = Logger();

  AuthDataSource get auth => AuthDataSourceImpl(_client);

  OpenChatDataSource get openChat =>
      OpenChatDataSourceImpl(client: _client, logger: _logger);

  OpenChatMessageDataSource get openChatMessage =>
      OpenChatMessageDataSourceImpl(client: _client, logger: _logger);

  PrivateChatMessageDataSource get privateChatMessage =>
      PrivateChatMessageDataSourceImpl(client: _client, logger: _logger);
}
