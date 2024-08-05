part of "../auth.usecase_module.dart";

class FindByUidUseCase {
  final AuthRepository _repository;

  FindByUidUseCase(this._repository);

  Future<ResponseWrapper<PresenceEntity>> call(String uid) async =>
      await _repository.findByUid(uid);
}
