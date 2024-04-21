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
  Future<KakaoApiResponseMapper<LoadAddressModel>>
      getCurrentAddressByCoordinate(
          {required double x, required double y}) async {
    try {
      final res = await _dio.get(
          KakaoMapApiEndPoint.getAddressFromCoordinate.endPoint,
          queryParameters: {'x': x, 'y': y},
          options: Options(headers: {'Authorization': kakaoApiKey}));
      _logger.d(res);
      return KakaoApiResponseMapper<LoadAddressModel>.fromResponse(res);
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<Position> getCurrentPosition() async {
    try {
      final pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _logger.d(
          'current longitude : ${pos.longitude} / latitude : ${pos.latitude}');
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
