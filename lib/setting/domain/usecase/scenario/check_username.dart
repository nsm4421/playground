part of '../usecase.dart';

class CheckUsernameUseCase {
  final AccountRepository _repository;

  CheckUsernameUseCase(this._repository);

  Future<ResponseWrapper<void>> call(String username) async {
    log('[CheckUsernameUseCase]유저명 사용가능여부 조회');
    try {
      return await _repository.checkUsername(username).then((res) =>
          res.copyWith(message: res.ok ? '사용 가능한 유저명입니다' : '중복된 유저명입니다'));
    } catch (error) {
      log(error.toString());
      return const ErrorResponse(message: '알 수 없는 오류가 발생');
    }
  }
}
