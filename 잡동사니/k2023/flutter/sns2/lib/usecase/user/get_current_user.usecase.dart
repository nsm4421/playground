import 'package:my_app/repository/user/user.repository.dart';

import '../../core/response/response.dart';
import '../../domain/model/user/user.model.dart';
import '../base/remote.usecase.dart';

class GetCurrentUserUsecase extends RemoteUsecase<UserRepository> {
  GetCurrentUserUsecase();

  @override
  Future<Response<UserModel?>> call(UserRepository repository) async =>
      await repository.getCurrentUser();
}
