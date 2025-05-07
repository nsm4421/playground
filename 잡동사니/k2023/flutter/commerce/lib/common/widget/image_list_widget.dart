import 'package:flutter/material.dart';

import '../../domain/model/product_info_model.dart';
import 'product_card_widget.dart';
import 'size_widget.dart';

class ImageListWidget extends StatelessWidget {
  const ImageListWidget({super.key, required List<ProductInfoModel> products})
      : _products = products;
  static const double _aspectRatio = 375 / 305;
  static const double _aspectRatioCard = 150 / 305;
  static const double _horizontalPadding = 16;
  final List<ProductInfoModel> _products;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _aspectRatio,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
        itemBuilder: (_, index) {
          return AspectRatio(
            aspectRatio: _aspectRatioCard,
            child: LargeProductCardComponent(
              context: context,
              productInfoModel: _products[index],
            ),
          );
        },
        separatorBuilder: (_, __) => Width(8),
        itemCount: _products.length,
      ),
    );
  }
}
