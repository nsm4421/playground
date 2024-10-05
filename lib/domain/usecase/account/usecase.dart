import 'package:injectable/injectable.dart';
import 'package:travel/domain/repository/account/repository.dart';

part 'scenario/check_username.dart';

class AccountUseCase {
  final AccountRepository _repository;

  AccountUseCase(this._repository);

  CheckUsernameUseCase get isUsernameDuplicated =>
      CheckUsernameUseCase(_repository);
}
