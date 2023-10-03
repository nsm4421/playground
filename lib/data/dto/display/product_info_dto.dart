import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/product_info_dto.freezed.dart';

part '../../../generated/product_info_dto.g.dart';


@freezed
class ProductInfoDto with _$ProductInfoDto {
  const factory ProductInfoDto({
    @Default('') String productId,
    @Default('') String name,
    @Default('') String imageUrl,
    @Default('') String description,
    @Default(-1) int price, // 판매가
    @Default(-1) int originalPrice, // 원가
    @Default(-1) int discountAmount, // 할인액
    @Default(-1) int reviewCount,
  }) = _ProductInfoDto;

  factory ProductInfoDto.fromJson(Map<String, dynamic> json) =>
      _$ProductInfoDtoFromJson(json);
}
