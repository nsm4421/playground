import 'package:geolocator/geolocator.dart';
import 'package:hot_place/core/constant/map.constant.dart';
import 'package:hot_place/core/constant/response.constant.dart';
import 'package:hot_place/data/data_source/map/map.data_source.dart';
import 'package:hot_place/data/model/map/address/address.model.dart';
import 'package:hot_place/data/model/map/place/place.model.dart';
import 'package:hot_place/data/model/response/response.model.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../domain/entity/map/address/address.entity.dart';
import '../../../domain/entity/map/place/place.entity.dart';
import '../../../domain/repository/map/map.repository.dart';
import '../../model/map/response/kakao_map_api_response.model.dart';

@Singleton(as: MapRepository)
class MapRepositoryImpl extends MapRepository {
  final MapDataSource _mapDataSource;
  final _logger = Logger();

  MapRepositoryImpl({required MapDataSource mapDataSource})
      : _mapDataSource = mapDataSource;

  @override
  Future<ResponseModel<Position>> getCurrentLocation() async {
    try {
      final location = await _mapDataSource.getCurrentLocation();
      return ResponseModel<Position>.success(data: location);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<Position>.error();
    }
  }

  @override
  Future<ResponseModel<KakaoMapApiResponseModel<AddressEntity>>> searchAddress(
      {required String keyword, required int page, required int size}) async {
    try {
      final res = await _mapDataSource.searchAddress(
          keyword: keyword, page: page, size: size);
      final data = res
          .convert<AddressEntity>(res.data.map((e) => e.toEntity()).toList());
      return ResponseModel<KakaoMapApiResponseModel<AddressEntity>>.success(
          data: data);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<KakaoMapApiResponseModel<AddressEntity>>.error();
    }
  }

  @override
  Future<ResponseModel<KakaoMapApiResponseModel<PlaceEntity>>>
      searchPlacesByCategoryAndKeyword({
    required String keyword,
    CategoryGroupCode? category,
    Position? position,
    required int page,
    required int size,
    required int radius,
  }) async {
    try {
      final currentLocation = position ?? (await getCurrentLocation()).data!;
      final res = await _mapDataSource.searchPlacesByCategoryAndKeyword(
          keyword: keyword,
          category: category,
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude,
          page: page,
          size: size,
          radius: radius);
      final data = res.data.map((e) => e.toEntity()).toList();
      return ResponseModel<KakaoMapApiResponseModel<PlaceEntity>>.success(
          data: res.convert<PlaceEntity>(data));
    } catch (err) {
      _logger.e(err);
      return ResponseModel<KakaoMapApiResponseModel<PlaceEntity>>.error();
    }
  }

  @override
  Future<ResponseModel<KakaoMapApiResponseModel<PlaceEntity>>>
      searchPlacesByCategory({
    required CategoryGroupCode category,
    Position? position,
    required int page,
    required int size,
    required int radius,
  }) async {
    try {
      final currentLocation = position ?? (await getCurrentLocation()).data!;
      final res = await _mapDataSource.searchPlaceByCategory(
          category: category,
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude,
          page: page,
          size: size,
          radius: radius);
      final data = res.data.map((e) => e.toEntity()).toList();
      return ResponseModel<KakaoMapApiResponseModel<PlaceEntity>>.success(
          data: res.convert<PlaceEntity>(data));
    } catch (err) {
      _logger.e(err);
      return ResponseModel<KakaoMapApiResponseModel<PlaceEntity>>.error();
    }
  }
}
