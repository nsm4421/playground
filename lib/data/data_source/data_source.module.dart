import 'package:hot_place/data/data_source/auth/auth.data_source.dart';
import 'package:hot_place/data/data_source/auth/auth.remote_data_source.dart';
import 'package:hot_place/data/data_source/chat/chat.data_source.dart';
import 'package:hot_place/data/data_source/chat/chat.remote_data_source.dart';
import 'package:hot_place/data/data_source/feed/feed.data_source.dart';
import 'package:hot_place/data/data_source/feed/feed.remote_data_source.dart';
import 'package:hot_place/data/data_source/like/like_feed.data_source.dart';
import 'package:hot_place/data/data_source/like/like_feed.remote_data_source.dart';
import 'package:hot_place/data/data_source/user/user.data_source.dart';
import 'package:hot_place/data/data_source/user/user.remote_data_source.dart';

import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@module
abstract class DataSource {
  final _client = Supabase.instance.client;

  @singleton
  AuthDataSource get authDataSource =>
      RemoteAuthDataSource(auth: _client.auth, db: _client.rest);

  @singleton
  UserDataSource get userDataSource => RemoteUserDataSource(
      auth: _client.auth, db: _client.rest, storage: _client.storage);

  @singleton
  FeedDataSource get feedDataSource => RemoteFeedDataSource(
      auth: _client.auth, db: _client.rest, storage: _client.storage);

  @singleton
  LikeFeedDataSource get likeFeedDataSource =>
      RemoteLikeFeedDataSource(auth: _client.auth, db: _client.rest);

  @singleton
  ChatDataSource get chatDataSource =>
      RemoteChatDataSource(auth: _client.auth, db: _client.rest, storage:_client.storage);
}
