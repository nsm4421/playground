import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'itinerary.model.freezed.dart';

part 'itinerary.model.g.dart';

@freezed
class ItineraryModel with _$ItineraryModel {
  const factory ItineraryModel({
    @Default('') String longitude,
    @Default('') String latitude,
    @Default('') String place_name,
    @Default('') String image_url,
    @Default('') String detail,
  }) = _ItineraryModel;

  factory ItineraryModel.fromJson(Map<String, dynamic> json) =>
      _$ItineraryModelFromJson(json);
}
