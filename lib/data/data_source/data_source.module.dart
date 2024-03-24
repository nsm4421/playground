import 'package:hot_place/data/data_source/auth/auth.data_source.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DataSource {
  @singleton
  AuthDataSource get authDataSource => AuthDataSource();
}
