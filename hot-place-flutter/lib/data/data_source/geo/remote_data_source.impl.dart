import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hot_place/core/constant/map.constant.dart';

import 'package:hot_place/domain/model/geo/load_address/load_address.model.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constant/response.constant.dart';
import '../../../core/util/exeption.util.dart';
import 'remote_data_source.dart';

class RemoteGeoDataSourceImpl implements RemoteGeoDataSource {
  final SupabaseClient _client;
  final Dio _dio;
  final Geolocator _geoLocator;
  final Logger _logger;

  RemoteGeoDataSourceImpl(
      {required SupabaseClient client,
      required Dio dio,
      required Geolocator geoLocator,
      required Logger logger})
      : _client = client,
        _dio = dio,
        _geoLocator = geoLocator,
        _logger = logger;

  @override
  Future<Iterable<LoadAddressModel>> getCurrentAddressByCoordinate(
      {required double latitude, required double longitude}) async {
    try {
      // x: longitude, y : latitude
      final res = await _dio
          .get(KakaoMapApiEndPoint.getAddressFromCoordinate.endPoint,
              queryParameters: {'x': longitude, 'y': latitude},
              options: Options(headers: {'Authorization': kakaoApiKey}))
          .then((res) => res.data);
      _logger.d(res);
      return (res['documents'] as Iterable)
          .map((json) => LoadAddressModel.fromJson(json['road_address']));
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<Position> getCurrentPosition() async {
    try {
      // 개발환경에서는 상도동 주소를 현재 위치로 지정함
      if (dotenv.env['ENVIRONMENT'] == 'DEV') {
        return Position(
            longitude: 126.95089037512,
            latitude: 37.498924913712,
            timestamp: DateTime.now(),
            accuracy: 600,
            altitude: 0,
            heading: 0,
            speed: 0,
            speedAccuracy: 1.5);
      }
      final pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return pos;
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  String get kakaoApiKey => "KakaoAK ${dotenv.env['KAKAO_REST_API_KEY']}";

  @override
  Future<LocationPermission> getPermission() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      switch (permission) {
        case LocationPermission.always:
        case LocationPermission.whileInUse:
          return permission;
        case LocationPermission.denied:
        case LocationPermission.deniedForever:
          throw const PermissionDeniedException('위치권한이 거부되었습니다');
      }
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }
}
