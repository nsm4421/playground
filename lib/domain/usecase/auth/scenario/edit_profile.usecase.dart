part of "../auth.usecase_module.dart";

class EditProfileUseCase {
  final AuthRepository _repository;

  EditProfileUseCase(this._repository);

  Future<ResponseWrapper<User>> call(
      {required String uid, String? nickname, File? profileImage}) async {
    // 프로필 이미지 저장
    String? profileImageUrl;
    if (profileImage != null) {
      final storeRes = await _repository.upsertProfileImage(
          uid: uid, profileImage: profileImage);
      final publicUrl = storeRes.data;
      if (!storeRes.ok || publicUrl == null) {
        return ResponseWrapper.error(storeRes.message ?? 'sign up fail');
      }
    }

    // 유저정보 업데이트
    final insertRes = await _repository.updateAccount(
        uid: uid, nickname: nickname, profileImage: profileImageUrl);
    if (!insertRes.ok) {
      return ResponseWrapper.error(insertRes.message ?? 'update account fail');
    }

    // 메타정보 업데이트
    final metaDataRes = await _repository.updateMetaData(
        nickname: nickname, profileImage: profileImageUrl);
    final user = metaDataRes.data;
    if (!metaDataRes.ok || user == null) {
      return ResponseWrapper.error(
          metaDataRes.message ?? 'update meta data fail');
    }
    return ResponseWrapper.success(user);
  }
}
