import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hot_place/core/constant/map.constant.dart';
import 'package:hot_place/data/data_source/map/map.data_source.dart';

import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

import '../../../../core/util/response.util.dart';
import '../../../model/map/address/address.model.dart';
import '../../../model/map/place/place.model.dart';

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
  Future<KakaoApiResponseWrapper<AddressModel>> searchAddress(String keyword,
      {int? page, int? size}) async {
    _logger.d("장소 검색 키워드 $keyword / page : $page / size : $size");
    return await _dio
        .get('https://dapi.kakao.com/v2/local/search/address.json',
            queryParameters: {
              'query': keyword,
              'analyze_type': 'similar', // similar, exact
              'page': page ?? 1, // 최소: 1, 최대: 45, 기본값: 1
              'size': size ?? 10 // 최소: 1, 최대: 30, 기본값: 10
            },
            options: Options(headers: {
              'Authorization': 'KakaoAK ${dotenv.env['KAKAO_REST_API_KEY']}'
            }))
        .then((res) => KakaoApiResponseWrapper<AddressModel>(
            totalCount: res.data['meta']['total_count'],
            data: (res.data['documents'] as List)
                .map((e) => AddressModel.fromJson(e))
                .toList()));
  }

  @override
  Future<KakaoApiResponseWrapper<PlaceModel>> searchPlaceByCategory({
    required CategoryGroupCode category,
    required double latitude,
    required double longitude,
    int? page,
    int? radius,
    int? size,
  }) async {
    _logger.d(
        "카테고리 검색 - page : $page / size : $size / 카테고리 : ${category.description}");
    return await _dio
        .get('https://dapi.kakao.com/v2/local/search/category.json',
            queryParameters: {
              'category_group_code': category.name,
              'page': page ?? 1, // 1~45 사이의 값 (기본값: 1)
              'size': size ?? 10, // 1~15 사이의 값 (기본값: 15)
              'radius': radius ?? 200,
              // TODO : 위치 정보 수정하기 (일단 상도동 기준으로 검색하도록 설정해놓음)
              'y': '37.494705526855',
              'x': '126.95994559383',
              // 'y': latitude.toString(),
              // 'x': longitude.toString(),
              'sort': 'distance' // distance, accuracy(default)
            },
            options: Options(headers: {
              'Authorization': 'KakaoAK ${dotenv.env['KAKAO_REST_API_KEY']}'
            }))
        .then((res) {
      _logger.d(res.data);
      return KakaoApiResponseWrapper<PlaceModel>(
          totalCount: res.data['meta']['total_count'],
          data: (res.data['documents'] as List)
              .map((e) => PlaceModel.fromJson(e))
              .toList());
    });
  }
}
