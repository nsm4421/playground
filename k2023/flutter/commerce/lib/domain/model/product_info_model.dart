import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/product_info_model.freezed.dart';

part '../../generated/product_info_model.g.dart';

@freezed
class ProductInfoModel with _$ProductInfoModel {
  const factory ProductInfoModel({
    required String productId,
    required String name,
    required String imageUrl,
    required String description,
    required int price, // 판매가
    required int originalPrice, // 원가
    required double discountRate, // 할인율
    required int reviewCount,
  }) = _ProducInfotModel;

  factory ProductInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ProductInfoModelFromJson(json);
}
