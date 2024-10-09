import '../../../data/datasource/account/datasource.dart';

part 'repository_impl.dart';

abstract interface class AccountRepository {
  Future<bool> getIsUsernameDuplicated(String username);
}
