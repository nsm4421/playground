import 'package:hot_place/data/data_source/auth/auth.data_source.dart';
import 'package:hot_place/data/data_source/auth/auth.remote_data_source_impl.dart';
import 'package:hot_place/data/data_source/chat/message/chat_message.remote_data_source_impl.dart';
import 'package:hot_place/data/data_source/chat/open_chat/open_chat.data_source.dart';
import 'package:hot_place/data/data_source/chat/open_chat/open_chat.remote_data_source_impl.dart';
import 'package:hot_place/data/data_source/feed/feed.data_source.dart';
import 'package:hot_place/data/data_source/feed/feed.remote_data_source_impl.dart';
import 'package:hot_place/data/data_source/feed/like/like_feed.data_source.dart';
import 'package:hot_place/data/data_source/feed/like/like_feed.remote_data_source_impl.dart';
import 'package:hot_place/data/data_source/user/user.data_source.dart';
import 'package:hot_place/data/data_source/user/user.remote_data_source_impl.dart';

import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'chat/message/chat_message.data_source.dart';
import 'chat/message/chat_message.local_data_source_impl.dart';
import 'chat/open_chat/open_chat.local_data_source_impl.dart';
import 'feed/feed.local_data_source_impl.dart';

@module
abstract class DataSource {
  final _client = Supabase.instance.client;

  @singleton
  RemoteAuthDataSource get remoteAuthDataSource =>
      RemoteAuthDataSourceImpl(_client);

  @singleton
  UserDataSource get remoteUserDataSource => RemoteUserDataSource(_client);

  @singleton
  LocalFeedDataSource get localFeedDataSource => LocalFeedDataSourceImpl();

  @singleton
  RemoteFeedDataSource get remoteFeedDataSource =>
      RemoteFeedDataSourceImpl(_client);

  @singleton
  RemoteLikeFeedDataSource get remoteLikeFeedDataSource =>
      RemoteLikeFeedDataSourceImpl(_client);

  @singleton
  LocalOpenChatDataSource get localOpenChatDataSource =>
      LocalOpenChatDataSourceImpl();

  @singleton
  RemoteOpenChatDataSource get remoteOpenChatDataSource =>
      RemoteOpenChatDataSourceImpl(_client);

  @singleton
  RemoteChatMessageDataSource get remoteChatMessageDataSource =>
      RemoteChatMessageDataSourceImpl(_client);

  @singleton
  LocalChatMessageDataSource get localChatMessageDataSource =>
      LocalChatMessageDataSourceImpl();
}
