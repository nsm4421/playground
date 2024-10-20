part of '../usecase.dart';

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

class UpdateRegistrationsUseCase {
  final RegistrationRepository _repository;

  UpdateRegistrationsUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(
      {required String meetingId, required bool isPermitted}) async {
    return await _repository
        .update(meetingId: meetingId, isPermitted: isPermitted)
        .mapLeft((l) => l.copyWith(message: 'update registration fails'));
  }
}

class CancelRegistrationUseCase {
  final RegistrationRepository _repository;

  CancelRegistrationUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(String meetingId) async {
    return await _repository
        .deleteByMeetingId(meetingId)
        .mapLeft((l) => l.copyWith(message: 'update registration fails'));
  }
}
