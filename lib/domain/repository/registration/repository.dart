import 'package:either_dart/either.dart';
import 'package:travel/core/response/error_response.dart';
import 'package:travel/data/datasource/registration/datasource.dart';
import 'package:travel/domain/entity/registration/registration.dart';

import '../../../core/util/util.dart';

part 'repository_impl.dart';

abstract interface class RegistrationRepository {
  Future<Either<ErrorResponse, List<RegistrationEntity>>> fetch(
      String meetingId);

  Future<Either<ErrorResponse, void>> create(
      {required String meetingId, required String introduce});

  Future<Either<ErrorResponse, void>> update(
      {required String registrationId, required bool isPermitted});

  Future<Either<ErrorResponse, void>> deleteByMeetingId(String meetingId);
}
