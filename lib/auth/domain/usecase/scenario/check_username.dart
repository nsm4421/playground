part of '../usecase.dart';

class CheckUsernameUseCase {
  final AuthRepository _repository;

  CheckUsernameUseCase(this._repository);

  Future<ResponseWrapper<bool>> call(String username) async {
    final res = await _repository.checkUsername(username);
    if (res.ok && !res.data!) {
      return const SuccessResponse(message: '사용 가능한 유저명입니다');
    } else {
      return ErrorResponse(code: res.code, message: '중복된 유저명입니다');
    }
  }
}
