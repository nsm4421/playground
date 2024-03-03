import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hot_place/data/data_source/map/map.data_source.dart';

import 'package:geolocator/geolocator.dart';
import 'package:hot_place/data/model/map/place/place.model.dart';
import 'package:logger/logger.dart';

import '../../../../core/util/page.util.dart';

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

  /// 검색어로 조회해서 장소 조회
  @override
  Future<CustomPageable<PlaceModel>> searchPlaces(String keyword,
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
        .then((res) => CustomPageable<PlaceModel>(
            totalCount: res.data['meta']['total_count'],
            data: (res.data['documents'] as List)
                .map((e) => PlaceModel.fromJson(e))
                .toList()));
  }
}
