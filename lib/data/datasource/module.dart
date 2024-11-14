import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/data/datasource/auth/datasource.dart';
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
}
