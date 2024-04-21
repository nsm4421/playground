import 'package:geolocator/geolocator.dart';

import '../../../repository/geo/geo.repository.dart';

class GetCurrentPositionUseCase {
  final GeoRepository _repository;

  GetCurrentPositionUseCase(this._repository);

  Future<Position> call() async => await _repository.getCurrentLocation;
}
