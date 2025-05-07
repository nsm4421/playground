import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/data/datasource/auth/datasource.dart';
import 'package:travel/data/datasource/database/chat/datasource.dart';
import 'package:travel/data/datasource/database/comment/datasource.dart';
import 'package:travel/data/datasource/database/emotion/datasource.dart';
import 'package:travel/data/datasource/database/feed/datasource.dart';
import 'package:travel/data/datasource/database/reels/datasource.dart';
import 'package:travel/data/datasource/storage/datasource.dart';

@module
abstract class DataSourceModule {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  @lazySingleton
  AuthDataSource get auth => AuthDataSourceImpl(_supabaseClient);

  @lazySingleton
  StorageDataSource get storage => StorageDataSourceImpl(_supabaseClient);

  @lazySingleton
  FeedDataSource get feed => FeedDataSourceImpl(_supabaseClient);

  @lazySingleton
  ReelsDataSource get reels => ReelsDataSourceImpl(_supabaseClient);

  @lazySingleton
  CommentDataSource get comment => CommentDataSourceImpl(_supabaseClient);

  @lazySingleton
  EmotionDataSource get emotion => EmotionDataSourceImpl(_supabaseClient);

  @lazySingleton
  PrivateChatDataSource get privateChat =>
      PrivateChatDataSourceImpl(_supabaseClient);

  @lazySingleton
  PrivateMessageDataSource get privateMessage =>
      PrivateMessageDataSourceImpl(_supabaseClient);
}
