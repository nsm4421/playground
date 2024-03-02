import 'package:geolocator/geolocator.dart';

abstract class MapDataSource {
  Future<Position> getCurrentLocation();
}
