import 'package:geolocator/geolocator.dart';

abstract class MapRepository {
  Future<Position> getCurrentLocation();
}