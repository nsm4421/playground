import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../place/same_name/same_name.model.dart';

part 'kakao_map_api_response.model.freezed.dart';

part 'kakao_map_api_response.model.g.dart';

@Freezed(genericArgumentFactories: true)
class KakaoMapApiResponseModel<T> with _$KakaoMapApiResponseModel<T> {
  const factory KakaoMapApiResponseModel(
      {@Default(0) int totalCount,
      @Default(0) int pageableCount,
      @Default(false) bool isEnd,
      SameNameModel? sameName,
      @Default([]) List<T> data}) = _KakaoMapApiResponseModel;

  factory KakaoMapApiResponseModel.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$KakaoMapApiResponseModelFromJson(json, fromJsonT);
}

extension KakaoMapApiResponseModelEx<S> on KakaoMapApiResponseModel {
  KakaoMapApiResponseModel<S> convert<S>(List<S> newData) =>
      KakaoMapApiResponseModel<S>(
          totalCount: totalCount,
          pageableCount: pageableCount,
          isEnd: isEnd,
          sameName: sameName,
          data: newData);
}
