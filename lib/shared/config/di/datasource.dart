import 'package:flutter_app/auth/data/datasource/datasource_impl.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@module
abstract class DataSource {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  @lazySingleton
  AuthDataSource get auth =>
      AuthDataSourceImpl(supabaseClient: _supabaseClient);
}
