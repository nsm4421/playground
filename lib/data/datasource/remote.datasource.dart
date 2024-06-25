import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:my_app/data/datasource/chat/open_chat_message/open_chat_message.datasource_impl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'chat/open_chat/open_chat.datasource_impl.dart';
import 'chat/private_chat_message/private_chat_message.datasource_impl.dart';
import 'like/like.datasource_impl.dart';
import 'user/account/account.datasource_impl.dart';
import 'user/auth/auth.datasource_impl.dart';
import 'feed/base/feed.datasource_impl.dart';
import 'feed/comment/feed_comment.datasource_impl.dart';

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
