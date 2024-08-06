part of "../auth.usecase_module.dart";

class CheckNicknameUseCase {
  final AuthRepository _repository;

  CheckNicknameUseCase(this._repository);

  Future<ResponseWrapper<bool>> call(String nickname) async {
    final res =
        await _repository.countByField(field: "nickname", value: nickname);
    if (res.ok && res.data == 0) {
      return ResponseWrapper.success(true);
    }
    return ResponseWrapper.error(res.message);
  }
}
