part of 'repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountDataSource _accountDataSource;

  AccountRepositoryImpl(this._accountDataSource);

  @override
  Future<bool> getIsUsernameDuplicated(String username) async {
    return await _accountDataSource.isUsernameDuplicated(username);
  }
}
