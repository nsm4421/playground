import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/data/data_source/base/auth.api.dart';
import 'package:my_app/data/data_source/remote/auth.remote_api.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@module
abstract class DataSourceModule {
  final bool _isDebug = dotenv.env['MODE'] == 'debug';
  final _auth = Supabase.instance.client.auth;
  final _rest = Supabase.instance.client.rest;

  GoTrueClient get auth => _auth;

  PostgrestClient get rest => _rest;

  @singleton
  AuthApi get authApi => RemoteAuthApi(_auth);
}
