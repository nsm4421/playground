import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/data/data_source/base/auth.api.dart';
import 'package:my_app/data/data_source/base/rest.api.dart';
import 'package:my_app/data/data_source/base/storage.api.dart';
import 'package:my_app/data/data_source/remote/auth.remote_api.dart';
import 'package:my_app/data/data_source/remote/rest.remote_api.dart';
import 'package:my_app/data/data_source/remote/storage.remote_api.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@module
abstract class DataSourceModule {
  final bool _isDebug = dotenv.env['MODE'] == 'debug';
  final _client = Supabase.instance.client;

  @singleton
  AuthApi get authApi => RemoteAuthApi(_client.auth);

  @singleton
  RestApi get restApi => RemoteRestApi(_client);

  @singleton
  StorageApi get storageApi => RemoteStorageApi(_client.storage);
}
