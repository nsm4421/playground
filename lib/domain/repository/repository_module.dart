import 'package:injectable/injectable.dart';

import '../../data/datasource/datasource_module.dart';
import 'account/repository.dart';
import 'auth/repository.dart';
import 'diary/repository.dart';

@lazySingleton
class RepositoryModule {
  final DataSourceModule _dataSourceModule;

  RepositoryModule(this._dataSourceModule);

  @lazySingleton
  AuthRepository get auth => AuthRepositoryImpl(
      authDataSource: _dataSourceModule.auth,
      storageDataSource: _dataSourceModule.storage,
      localDataSource: _dataSourceModule.local);

  @lazySingleton
  AccountRepository get account =>
      AccountRepositoryImpl(_dataSourceModule.account);

  @lazySingleton
  DiaryRepository get diary => DiaryRepositoryImpl(
      diaryDataSource: _dataSourceModule.diary,
      storageDataSource: _dataSourceModule.storage);
}
