import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/data/datasource/storage/datasource.dart';

import 'auth/datasource.dart';

@module
abstract class DataSourceModule {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  @lazySingleton
  AuthDataSource get auth => AuthDataSourceImpl(_supabaseClient);

  @lazySingleton
  StorageDataSource get storage =>
      StorageDataSourceImpl( _supabaseClient);
}
