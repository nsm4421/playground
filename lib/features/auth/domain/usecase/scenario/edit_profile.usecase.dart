part of "../auth.usecase_module.dart";

class EditProfileUseCase {
  final AuthRepository _repository;

  EditProfileUseCase(this._repository);

  Future<ResponseWrapper<User>> call(
      {required String uid, String? nickname, String? profileImage}) async {
    // 메타정보 업데이트
    final metaDataRes = await _repository.updateMetaData(
        nickname: nickname, profileImage: profileImage);
    final user = metaDataRes.data;
    if (!metaDataRes.ok || user == null) {
      return ResponseWrapper.error(
          metaDataRes.message ?? 'update meta data fail');
    }
    // 유저정보 업데이트
    final updateRes = await _repository.updateAccount(
        uid: uid, nickname: nickname, profileImage: profileImage);
    if (!updateRes.ok) {
      return ResponseWrapper.error(
          updateRes.message ?? 'update account table fail');
    }
    return ResponseWrapper.success(user);
  }
}
