import 'package:either_dart/either.dart';
import 'package:travel/domain/entity/registration/registration.dart';
import 'package:travel/domain/repository/registration/repository.dart';

import '../../../core/response/error_response.dart';

part 'scenrario/crud.dart';

class RegistrationUseCase {
  final RegistrationRepository _repository;

  RegistrationUseCase(this._repository);

  SubmitRegistrationUseCase get register =>
      SubmitRegistrationUseCase(_repository);

  FetchRegistrationsUseCase get fetch => FetchRegistrationsUseCase(_repository);

  PermitRegistrationsUseCase get permit =>
      PermitRegistrationsUseCase(_repository);

  CancelPermitRegistrationUseCase get cancelPermit =>
      CancelPermitRegistrationUseCase(_repository);

  DeleteRegistrationUseCase get delete =>
      DeleteRegistrationUseCase(_repository);
}
