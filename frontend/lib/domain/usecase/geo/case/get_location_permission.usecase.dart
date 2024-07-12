import 'package:hot_place/domain/repository/geo/geo.repository.dart';

class GetLocationPermissionUseCase {
  final GeoRepository _repository;

  GetLocationPermissionUseCase(this._repository);

  Future<bool> call() async {
    return _repository.getPermission();
  }
}
