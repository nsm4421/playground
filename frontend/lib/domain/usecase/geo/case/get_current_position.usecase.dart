import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hot_place/core/error/failure.constant.dart';

import '../../../repository/geo/geo.repository.dart';

class GetCurrentPositionUseCase {
  final GeoRepository _repository;

  GetCurrentPositionUseCase(this._repository);

  Future<Either<Failure, Position>> call() async =>
      await _repository.getCurrentLocation;
}
