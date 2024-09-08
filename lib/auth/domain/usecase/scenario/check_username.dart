part of '../usecase.dart';

class CheckUsernameUseCase {
  final AuthRepository _repository;

  CheckUsernameUseCase(this._repository);

  Future<UseCaseResponseWrapper<bool>> call(String username) async {
    return await _repository.checkUsername(username).then((res) =>
        UseCaseResponseWrapper.from(res,
            errorMessage: '$username은 중복된 유저명입니다.'));
  }
}
