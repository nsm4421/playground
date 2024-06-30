import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:my_app/data/datasource/chat/impl/open_chat_message.remote_datasource_impl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'chat/impl/open_chat.remote_datasource_impl.dart';
import 'chat/impl/private_chat_message.remote_datasource_impl.dart';
import 'feed/impl/like.remote_datasource_impl.dart';
import 'user/impl/account.remote_datasource_impl.dart';
import 'user/impl/auth.remote_datasource_impl.dart';
import 'feed/impl/feed.remote_datasource_impl.dart';
import 'feed/impl/feed_comment.remote_datasource_impl.dart';

@module
abstract class RemoteDataSource {
  final _client = Supabase.instance.client;
  final _logger = Logger();

  @singleton
  RemoteAuthDataSource get auth =>
      RemoteAuthDataSourceImpl(client: _client, logger: _logger);

  @singleton
  RemoteAccountDataSource get user =>
      RemoteAccountDataSourceImpl(client: _client, logger: _logger);

  @lazySingleton
  RemoteFeedDataSource get feed =>
      RemoteFeedDataSourceImpl(client: _client, logger: _logger);

  @lazySingleton
  RemoteFeedCommentDataSource get feedComment =>
      RemoteFeedCommentDataSourceImpl(client: _client, logger: _logger);

  @lazySingleton
  RemoteLikeDataSource get like =>
      RemoteLikeDataSourceImpl(client: _client, logger: _logger);

  @lazySingleton
  RemoteOpenChatDataSource get openChat =>
      RemoteOpenChatDataSourceImpl(client: _client, logger: _logger);

  @lazySingleton
  RemoteOpenChatMessageDataSource get openChatMessage =>
      RemoteOpenChatMessageDataSourceImpl(client: _client, logger: _logger);

  @lazySingleton
  RemotePrivateChatMessageDataSource get privateChatMessage =>
      RemotePrivateChatMessageDataSourceImpl(client: _client, logger: _logger);
}
