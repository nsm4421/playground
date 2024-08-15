import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/data/model/travel/itinerary.model.dart';

part 'itinerary.entity.freezed.dart';

@freezed
class ItineraryEntity with _$ItineraryEntity {
  const factory ItineraryEntity({
    double? longitude,
    double? latitude,
    String? placeName,
    String? imageUrl,
    String? detail,
  }) = _ItineraryEntity;

  factory ItineraryEntity.fromModel(ItineraryModel model) => ItineraryEntity(
        longitude: model.longitude.isNotEmpty
            ? double.tryParse(model.longitude)
            : null,
        latitude:
            model.latitude.isNotEmpty ? double.tryParse(model.latitude) : null,
        placeName: model.place_name.isNotEmpty ? model.place_name : null,
        imageUrl: model.image_url.isNotEmpty ? model.image_url : null,
        detail: model.detail.isNotEmpty ? model.detail : null,
      );
}
