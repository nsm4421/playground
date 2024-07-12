import 'package:hot_place/domain/repository/geo/geo.repository.dart';
import 'package:hot_place/domain/usecase/geo/case/get_current_address.usecase.dart';
import 'package:hot_place/domain/usecase/geo/case/get_current_position.usecase.dart';
import 'package:hot_place/domain/usecase/geo/case/get_location_permission.usecase.dart';
import 'package:injectable/injectable.dart';

import 'case/get_users_near_by.usecase.dart';

@lazySingleton
class GeoUseCase {
  final GeoRepository _repository;

  GeoUseCase(this._repository);

  @injectable
  GetLocationPermissionUseCase get getPermission =>
      GetLocationPermissionUseCase(_repository);

  @injectable
  GetCurrentPositionUseCase get getPosition =>
      GetCurrentPositionUseCase(_repository);

  @injectable
  GetCurrentAddressUseCase get getAddress =>
      GetCurrentAddressUseCase(_repository);

  // TODO : 근처 유저들을 조회하는 기능
  @injectable
  GetUsersNearByUseCase get findUsers => throw UnimplementedError();
}
