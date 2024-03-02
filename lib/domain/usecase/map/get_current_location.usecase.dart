import 'package:geolocator/geolocator.dart';
import 'package:hot_place/domain/repository/map/Map.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetCurrentLocationUseCase {
  final MapRepository _repository;

  GetCurrentLocationUseCase(this._repository);

  Future<Position> call() async => await _repository.getCurrentLocation();
}
