import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/data/datasource/account/datasource.dart';
import 'package:travel/data/datasource/auth/datasource.dart';
import 'package:travel/data/datasource/diary/datsource.dart';
import 'package:travel/data/datasource/storage/datasource.dart';

import 'local/datasource.dart';

@lazySingleton
class DataSourceModule {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  AuthDataSource get auth => AuthDataSourceImpl(_supabaseClient);

  LocalDataSource get local => LocalDataSourceImpl();

  AccountDataSource get account => AccountDataSourceImpl(_supabaseClient);

  DiaryDataSource get diary => DiaryDataSourceImpl(_supabaseClient);

  StorageDataSource get storage => StorageDataSourceImpl(_supabaseClient);
}
