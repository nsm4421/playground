part of '../usecase.dart';

/// 여행 참가신청
class SubmitRegistrationUseCase {
  final RegistrationRepository _repository;

  SubmitRegistrationUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(
      {required String meetingId, required String introduce}) async {
    return await _repository
        .create(meetingId: meetingId, introduce: introduce)
        .mapLeft((l) => l.copyWith(message: 'submit registration fails'));
  }
}

/// 참가신청한 유저 목록 가져오기
class FetchRegistrationsUseCase {
  final RegistrationRepository _repository;

  FetchRegistrationsUseCase(this._repository);

  Future<Either<ErrorResponse, List<RegistrationEntity>>> call(
      String meetingId) async {
    return await _repository
        .fetch(meetingId)
        .mapLeft((l) => l.copyWith(message: 'fetching registration fails'));
  }
}

/// 참가신청 취소하기
class DeleteRegistrationUseCase {
  final RegistrationRepository _repository;

  DeleteRegistrationUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(String meetingId) async {
    return await _repository
        .deleteByMeetingId(meetingId)
        .mapLeft((l) => l.copyWith(message: 'update registration fails'));
  }
}

/// (방장이) 참가신청 허용하기
class PermitRegistrationsUseCase {
  final RegistrationRepository _repository;

  PermitRegistrationsUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(String registrationId) async {
    return await _repository
        .update(registrationId: registrationId, isPermitted: true)
        .mapLeft((l) => l.copyWith(message: 'permit fails'));
  }
}

/// (방장이) 참가신청 거절하기
class CancelPermitRegistrationUseCase {
  final RegistrationRepository _repository;

  CancelPermitRegistrationUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(String registrationId) async {
    return await _repository
        .update(registrationId: registrationId, isPermitted: false)
        .mapLeft((l) => l.copyWith(message: 'cancel permit fails'));
  }
}
