import 'package:geolocator/geolocator.dart';
import 'package:hot_place/domain/entity/result/result.entity.dart';
import 'package:hot_place/domain/repository/map/map.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetCurrentLocationUseCase {
  final MapRepository _repository;

  GetCurrentLocationUseCase(this._repository);

  Future<ResultEntity<Position>> call() async => await _repository
      .getCurrentLocation()
      .then(ResultEntity<Position>.fromResponse);
}
