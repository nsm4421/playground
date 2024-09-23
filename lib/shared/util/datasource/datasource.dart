import 'package:flutter_app/shared/shared.export.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../auth/auth.export.dart';
import '../../../comment/comment.export.dart';
import '../../../feed/feed.export.dart';
import '../../../like/like.export.dart';

@module
abstract class DataSource {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  final Logger _logger = Logger();

  @lazySingleton
  AuthDataSource get auth =>
      AuthDataSourceImpl(supabaseClient: _supabaseClient, logger: _logger);

  @lazySingleton
  FeedDataSource get feed =>
      FeedDataSourceImpl(supabaseClient: _supabaseClient, logger: _logger);

  @lazySingleton
  CommentDataSource get feedComment =>
      CommentDataSourceImpl(supabaseClient: _supabaseClient, logger: _logger);

  @lazySingleton
  LikeDataSource get like =>
      LikeDataSourceImpl(supabaseClient: _supabaseClient, logger: _logger);

  @lazySingleton
  StorageDataSource get storage =>
      StorageDataSource(supabaseClient: _supabaseClient, logger: _logger);
}
