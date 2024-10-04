import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/data/datasource/account/datasource.dart';
import 'package:travel/data/datasource/auth/datasource.dart';
import 'package:travel/data/datasource/diary/datsource.dart';
import 'package:travel/data/datasource/storage/datasource.dart';

import 'local/datasource.dart';

@module
abstract class DatasourceModule {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  @lazySingleton
  AuthDataSource get auth => AuthDataSourceImpl(_supabaseClient);

  @lazySingleton
  LocalDataSource get local => LocalDataSourceImpl();

  @lazySingleton
  AccountDataSource get account => AccountDataSourceImpl(_supabaseClient);

  @lazySingleton
  DiaryDataSource get diary => DiaryDataSourceImpl(_supabaseClient);

  @lazySingleton
  StorageDataSource get storage => StorageDataSourceImpl(_supabaseClient);
}
