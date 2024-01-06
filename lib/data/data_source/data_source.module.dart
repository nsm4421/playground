import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth/auth.api.dart';

@module
abstract class DataSourceModule {
  final SupabaseClient _supabaseClient = SupabaseClient(
    dotenv.env['DB_URL']!,
    dotenv.env['ANON_KEY']!,
  );

  @singleton
  AuthApi get authApi => AuthApi(_supabaseClient);
}
