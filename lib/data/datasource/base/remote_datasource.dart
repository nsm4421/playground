import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:logger/logger.dart';

import '../remote/auth/abstract/auth.remote_datasource.dart';
import '../remote/chat/impl/open_chat.remote_datasource_impl.dart';
import '../remote/chat/impl/open_chat_message.remote_datasource_impl.dart';
import '../remote/chat/impl/private_chat_message.remote_datasource_impl.dart';
import '../remote/emotion/impl/emotion.remote_datasource_impl.dart';
import '../remote/feed/impl/feed.remote_datasource_impl.dart';
import '../remote/feed/impl/feed_comment.remote_datasource_impl.dart';

abstract interface class BaseRemoteDataSource<T> {
  String get tableName;

  T audit(T model);
}

@module
abstract class RemoteDataSource {
  final _client = Supabase.instance.client;
  final _logger = Logger(
      level: (dotenv.env['ENV'] == 'PROD') ? Level.error : null,
      printer: PrettyPrinter(
          methodCount: 2,
          errorMethodCount: 8,
          lineLength: 120,
          colors: true,
          printEmojis: true,
          printTime: false));

  /// 인증기능
  AuthRemoteDataSource get auth =>
      AuthRemoteDataSourceImpl(client: _client, logger: _logger);

  /// 피드
  FeedRemoteDataSource get feed =>
      FeedRemoteDataSourceImpl(client: _client, logger: _logger);

  FeedCommentRemoteDataSource get feedComment =>
      FeedCommentRemoteDataSourceImpl(client: _client, logger: _logger);

  /// 좋아요
  EmotionRemoteDataSource get emotion =>
      EmotionRemoteDataSourceImpl(client: _client, logger: _logger);

  /// 채팅
  OpenChatRemoteDataSource get openChat =>
      OpenChatRemoteDataSourceImpl(client: _client, logger: _logger);

  OpenChatMessageRemoteDataSource get openChatMessage =>
      OpenChatMessageRemoteDataSourceImpl(client: _client, logger: _logger);

  PrivateChatMessageRemoteDataSource get privateChatMessage =>
      PrivateChatMessageRemoteDataSourceImpl(client: _client, logger: _logger);
}
