import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/error/failure.constant.dart';
import '../../../../data/entity/geo/load_address/load_address.entity.dart';
import '../../../repository/geo/geo.repository.dart';

class GetCurrentAddressUseCase {
  final GeoRepository _repository;

  GetCurrentAddressUseCase(this._repository);

  Future<Either<Failure, Iterable<LoadAddressEntity>>> call(Position position,
      {int? limit}) async {
    return await _repository
        .getCurrentAddressByCoordinate(
            latitude: position.latitude, longitude: position.longitude)
        .then((res) => res.fold((l) => left(l),
            (r) => limit == null ? right(r) : right(r.take(limit))));
  }
}
