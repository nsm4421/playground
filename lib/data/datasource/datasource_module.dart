import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/env/env.dart';
import 'account/datasource.dart';
import 'auth/datasource.dart';
import 'channel/datasource.dart';
import 'chat/open_chat/datasource.dart';
import 'chat/private_chat/datasource.dart';
import 'diary/datsource.dart';
import 'local/datasource.dart';
import 'meeting/datasource.dart';
import 'reels/datasource.dart';
import 'storage/datasource.dart';

@lazySingleton
class DataSourceModule {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  final mode = Env.mode;

  @lazySingleton
  AuthDataSource get auth => mode == 'dev'
      ? MockAuthDataSource()
      : AuthDataSourceImpl(_supabaseClient);

  @lazySingleton
  LocalDataSource get local => LocalDataSourceImpl();

  @lazySingleton
  AccountDataSource get account => AccountDataSourceImpl(_supabaseClient);

  @lazySingleton
  DiaryDataSource get diary => mode == 'dev'
      ? MockDiaryDataSource()
      : DiaryDataSourceImpl(_supabaseClient);

  @lazySingleton
  OpenChatRoomDataSource get openChat =>
      OpenChatRoomDataSourceImpl(_supabaseClient);

  @lazySingleton
  OpenChatMessageDataSource get openChatMessage =>
      OpenChatMessageDataSourceImpl(_supabaseClient);

  @lazySingleton
  PrivateChatRoomDataSource get privateChat =>
      PrivateChatRoomDataSourceImpl(_supabaseClient);

  @lazySingleton
  PrivateChatMessageDataSource get privateChatMessage =>
      PrivateChatMessageDataSourceImpl(_supabaseClient);

  @lazySingleton
  MeetingDataSource get meeting => MeetingDataSourceImpl(_supabaseClient);

  @lazySingleton
  ReelsDataSource get reels => ReelsDataSourceImpl(_supabaseClient);

  @lazySingleton
  StorageDataSource get storage => StorageDataSourceImpl(_supabaseClient);

  @lazySingleton
  ChannelDataSource get channel => ChannelDataSourceImpl(_supabaseClient);
}
