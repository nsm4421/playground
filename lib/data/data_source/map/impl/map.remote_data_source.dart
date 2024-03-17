import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hot_place/core/constant/map.constant.dart';
import 'package:hot_place/data/data_source/map/map.data_source.dart';

import 'package:geolocator/geolocator.dart';
import 'package:hot_place/data/model/map/place/same_name/same_name.model.dart';
import 'package:logger/logger.dart';

import '../../../model/map/address/address.model.dart';
import '../../../model/map/place/place.model.dart';
import '../../../model/map/response/kakao_map_api_response.model.dart';

class RemoteMapDatSource extends MapDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _fireStore;
  final Geolocator _geoLocator;
  final Dio _dio;

  final _logger = Logger();

  RemoteMapDatSource(
      {required FirebaseAuth auth,
      required FirebaseFirestore fireStore,
      required Geolocator geoLocator,
      required Dio dio})
      : _auth = auth,
        _fireStore = fireStore,
        _geoLocator = geoLocator,
        _dio = dio;

  @override
  Future<Position> getCurrentLocation() async =>
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

  /// 검색어로 조회해서 행정동 조회
  @override
  Future<KakaoMapApiResponseModel<AddressModel>> searchAddress(
      {required String keyword, required int page, required int size}) async {
    _logger.d("장소 검색 키워드 $keyword / page : $page / size : $size");
    return await _dio
        .get('https://dapi.kakao.com/v2/local/search/address.json',
            queryParameters: {
              'query': keyword,
              'analyze_type': 'similar', // similar, exact
              'page': page, // 최소: 1, 최대: 45, 기본값: 1
              'size': size // 최소: 1, 최대: 30, 기본값: 10
            },
            options: Options(headers: {
              'Authorization': 'KakaoAK ${dotenv.env['KAKAO_REST_API_KEY']}'
            }))
        .then((res) => KakaoMapApiResponseModel<AddressModel>(
            totalCount: res.data['meta']['total_count'],
            data: (res.data['documents'] as List)
                .map((e) => AddressModel.fromJson(e))
                .toList()));
  }

  /// 키워드로 장소 검색
  @override
  Future<KakaoMapApiResponseModel<PlaceModel>>
      searchPlacesByCategoryAndKeyword({
    required String keyword,
    CategoryGroupCode? category,
    required double latitude,
    required double longitude,
    required int page,
    required int radius,
    required int size,
  }) async =>
          await _dio
              .get('https://dapi.kakao.com/v2/local/search/keyword.json',
                  queryParameters: {
                    'query': keyword,
                    if (category != null) 'category_group_code': category.name,
                    'page': page, // 1~45 사이의 값 (기본값: 1)
                    'size': size, // 1~15 사이의 값 (기본값: 15)
                    'radius': radius,
                    'y': dotenv.env['ENVIRONMENT'] == 'development'
                        ? '37.494705526855'
                        : latitude.toString(),
                    'x': dotenv.env['ENVIRONMENT'] == 'development'
                        ? '126.95994559383'
                        : longitude.toString(),
                    'sort': 'distance' // distance, accuracy(default)
                  },
                  options: Options(headers: {
                    'Authorization':
                        'KakaoAK ${dotenv.env['KAKAO_REST_API_KEY']}'
                  }))
              .then((res) {
            _logger.d(res.data);
            final sameName = res.data['meta']['same_name'];
            return KakaoMapApiResponseModel<PlaceModel>(
                totalCount: res.data['meta']['total_count'],
                pageableCount: res.data['meta']['pageable_count'],
                isEnd: res.data['meta']['is_end'],
                sameName:
                    sameName != null ? SameNameModel.fromJson(sameName) : null,
                data: (res.data['documents'] as List)
                    .map((e) => PlaceModel.fromJson(e))
                    .toList());
          });

  /// 카테고리로 장소 검색
  @override
  Future<KakaoMapApiResponseModel<PlaceModel>> searchPlaceByCategory({
    required CategoryGroupCode category,
    required double latitude,
    required double longitude,
    required int page,
    required int radius,
    required int size,
  }) async =>
      await _dio
          .get('https://dapi.kakao.com/v2/local/search/category.json',
              queryParameters: {
                'category_group_code': category.name,
                'page': page, // 1~45 사이의 값 (기본값: 1)
                'size': size, // 1~15 사이의 값 (기본값: 15)
                'radius': radius,
                'y': dotenv.env['ENVIRONMENT'] == 'development'
                    ? '37.494705526855'
                    : latitude.toString(),
                'x': dotenv.env['ENVIRONMENT'] == 'development'
                    ? '126.95994559383'
                    : longitude.toString(),
                'sort': 'distance' // distance, accuracy(default)
              },
              options: Options(headers: {
                'Authorization': 'KakaoAK ${dotenv.env['KAKAO_REST_API_KEY']}'
              }))
          .then((res) {
        _logger.d(res.data);
        final sameName = res.data['meta']['same_name'];
        return KakaoMapApiResponseModel<PlaceModel>(
            totalCount: res.data['meta']['total_count'],
            pageableCount: res.data['meta']['pageable_count'],
            isEnd: res.data['meta']['is_end'],
            sameName:
                sameName != null ? SameNameModel.fromJson(sameName) : null,
            data: (res.data['documents'] as List)
                .map((e) => PlaceModel.fromJson(e))
                .toList());
      });
}
