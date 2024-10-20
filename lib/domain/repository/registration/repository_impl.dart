part of 'repository.dart';

class RegistrationRepositoryImpl implements RegistrationRepository {
  final RegistrationDataSource _registrationDataSource;

  RegistrationRepositoryImpl(
      {required RegistrationDataSource registrationDataSource})
      : _registrationDataSource = registrationDataSource;

  @override
  Future<Either<ErrorResponse, void>> create(String meetingId) async {
    try {
      return await _registrationDataSource.create(meetingId).then(Right.new);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, void>> deleteByMeetingId(
      String meetingId) async {
    try {
      return await _registrationDataSource
          .deleteByMeetingId(meetingId)
          .then(Right.new);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, List<RegistrationEntity>>> fetch(
      String meetingId) async {
    try {
      return await _registrationDataSource
          .fetch(meetingId)
          .then((res) => res.map(RegistrationEntity.from).toList())
          .then(Right.new);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, void>> update(
      {required String meetingId, required bool isPermitted}) async {
    try {
      return await _registrationDataSource
          .update(meetingId: meetingId, isPermitted: isPermitted)
          .then(Right.new);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }
}
