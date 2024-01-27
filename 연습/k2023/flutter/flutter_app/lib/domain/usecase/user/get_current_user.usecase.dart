import 'package:my_app/core/enums/response_status.enum.dart';
import 'package:my_app/core/response/error_response.dart';
import 'package:my_app/core/response/result.dart';
import 'package:my_app/domain/model/auth/user.model.dart';

import '../../repository/user/user.repository.dart';
import '../base/remote.usecase.dart';

class GetCurrentUserUseCase extends RemoteUseCase<UserRepository> {
  GetCurrentUserUseCase();

  @override
  Future call(UserRepository repository) async => await repository
      .getCurrentUser()
      .then((res) => res.status == ResponseStatus.success
          ? Result<UserModel>.success(res.data!)
          : Result<UserModel>.failure(ErrorResponse.fromResponseWrapper(res)));
}
