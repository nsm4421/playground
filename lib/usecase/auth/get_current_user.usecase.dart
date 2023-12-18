import 'package:my_app/repository/auth/auth.repository.dart';

import '../../core/response/response.dart';
import '../../domain/model/user/user.model.dart';
import '../base/remote.usecase.dart';

class GetCurrentUserUsecase extends RemoteUsecase<AuthRepository> {
  GetCurrentUserUsecase();

  @override
  Future<Response<UserModel?>> call(AuthRepository repository) async =>
      await repository.getCurrentUser();
}
