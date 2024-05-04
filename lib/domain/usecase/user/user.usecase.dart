import 'package:hot_place/domain/repository/user/user.repository.dart';
import 'package:hot_place/domain/usecase/user/case/get_profile.usecase.dart';
import 'package:hot_place/domain/usecase/user/case/modify_profile.usecase.dart';
import 'package:hot_place/domain/usecase/user/case/update_last_seen_at.usecase.dart';
import 'package:hot_place/domain/usecase/user/case/upsert_profile_image.usecae.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserUseCase {
  final UserRepository _repository;

  UserUseCase(this._repository);

  @injectable
  UpdateLastSeenAtUseCase get updateLastSeenAt =>
      UpdateLastSeenAtUseCase(_repository);

  @injectable
  GetProfileUseCase get getProfile => GetProfileUseCase(_repository);

  @injectable
  ModifyProfileUseCase get modifyProfile => ModifyProfileUseCase(_repository);

  @injectable
  UpsertProfileImageUseCase get upsertProfileImage =>
      UpsertProfileImageUseCase(_repository);
}
