import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio/data/datasource/emotion/impl/emotion.datasource_impl.dart';
import 'package:portfolio/data/datasource/feed/impl/feed.datasource_impl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:logger/logger.dart';

import '../auth/abstract/auth.datasource.dart';
import '../chat/impl/open_chat.datasource_impl.dart';
import '../chat/impl/open_chat_message.datasource_impl.dart';
import '../chat/impl/private_chat_message.datasource_impl.dart';
import '../feed/impl/feed_comment.datasource_impl.dart';

@module
abstract class RemoteDataSource {
  final _dio = Dio();
  final _client = Supabase.instance.client;
  final _logger = Logger();

  /// 인증기능
  AuthDataSource get auth => AuthDataSourceImpl(_client);

  /// 피드
  FeedDataSource get feed =>
      FeedDataSourceImpl(client: _client, logger: _logger);

  FeedCommentDataSource get feedComment =>
      FeedCommentDataSourceImpl(client: _client, logger: _logger);

  /// 좋아요
  EmotionDataSource get emotion =>
      EmotionDataSourceImpl(client: _client, logger: _logger);

  /// 채팅
  OpenChatDataSource get openChat =>
      OpenChatDataSourceImpl(client: _client, logger: _logger);

  OpenChatMessageDataSource get openChatMessage =>
      OpenChatMessageDataSourceImpl(client: _client, logger: _logger);

  PrivateChatMessageDataSource get privateChatMessage =>
      PrivateChatMessageDataSourceImpl(client: _client, logger: _logger);
}
