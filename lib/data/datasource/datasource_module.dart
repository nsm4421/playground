import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/data/datasource/account/datasource.dart';
import 'package:travel/data/datasource/auth/datasource.dart';
import 'package:travel/data/datasource/diary/datsource.dart';
import 'package:travel/data/datasource/storage/datasource.dart';

import '../../core/env/env.dart';
import 'local/datasource.dart';

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
  StorageDataSource get storage => StorageDataSourceImpl(_supabaseClient);
}
