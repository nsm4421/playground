import 'package:flutter_svg/flutter_svg.dart';

import '../theme/constant/app_colors.dart';
import '../theme/constant/icon_paths.dart';
import '../theme/custom/custom_font_weight.dart';
import '../theme/custom/custom_theme.dart';
import '../utils/common.dart';
import 'add_card_widget.dart';
import 'size_widget.dart';
import 'package:flutter/material.dart';

import '../../domain/model/product_info_model.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductInfoModel productInfoModel;
  final double imageAspectRatio;
  final TextStyle? titleTextStyle;
  final TextStyle? priceTextStyle;
  final TextStyle? discountTextStyle;
  final TextStyle? originalPriceTextStyle;
  final TextStyle? reviewCountTextStyle;
  final bool showReviewInfo;

  const ProductCardWidget({
    super.key,
    required ProductInfoModel this.productInfoModel,
    required double this.imageAspectRatio,
    this.titleTextStyle,
    this.priceTextStyle,
    this.discountTextStyle,
    this.originalPriceTextStyle,
    this.reviewCountTextStyle,
    required this.showReviewInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            // 이미지
            AspectRatio(
              aspectRatio: imageAspectRatio,
              child: Image.network(
                productInfoModel.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            // 추가하기 버튼
            AddCardButtonWidget(),
          ],
        ),
        Height(10),
        Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              // 상품명
              Text(
                '${productInfoModel.name}',
                style: titleTextStyle?.copyWithTitleTextStyle(),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Height(5),
              Row(
                children: [
                  // 할인금액
                  Text(
                    '${productInfoModel.discountRate.toInt()}%',
                    style: discountTextStyle?.copyWithDiscountTextStyle(),
                  ),
                  Width(5),
                  // 판매가격
                  Text(
                    '${productInfoModel.price.toString()}',
                    style: priceTextStyle?.copyWithPriceTextStyle(),
                  ),
                  Width(5),
                  // 원가
                  Text(
                    '${productInfoModel.originalPrice.krwFormat()}',
                    style: originalPriceTextStyle?.copyWithOriginalPriceTextStyle(),
                  ),
                ],
              ),
              Height(5),
              // 리뷰 개수
              if (showReviewInfo)
                Row(
                  children: [
                    Width(5),
                    SvgPicture.asset(
                      IconPaths.cart,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        AppColors.contentTertiary,
                        BlendMode.srcIn,
                      ),
                    ),
                    Width(5),
                    Text(
                      'Review ${productInfoModel.reviewCount.overMillion()}',
                      style: reviewCountTextStyle?.copyWithReviewCountTextStyle(),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class LargeProductCardComponent extends ProductCardWidget {
  final BuildContext context;

  LargeProductCardComponent({
    required this.context,
    required super.productInfoModel,
  }) : super(
          imageAspectRatio: 150 / 195,
          showReviewInfo: true,
          titleTextStyle: Theme.of(context).textTheme.titleSmall.regular,
          priceTextStyle: Theme.of(context).textTheme.titleSmall.bold,
          discountTextStyle: Theme.of(context).textTheme.titleSmall.regular,
          originalPriceTextStyle:
              Theme.of(context).textTheme.labelMedium.regular,
          reviewCountTextStyle: Theme.of(context).textTheme.labelSmall.regular,
        );
}

class SmallProductCardComponent extends ProductCardWidget {
  final BuildContext context;

  SmallProductCardComponent({
    required this.context,
    required super.productInfoModel,
  }) : super(
          imageAspectRatio: 114 / 152,
          showReviewInfo: false,
          titleTextStyle: Theme.of(context).textTheme.titleSmall.regular,
          priceTextStyle: Theme.of(context).textTheme.titleSmall.bold,
          discountTextStyle: Theme.of(context).textTheme.titleSmall.regular,
          originalPriceTextStyle:
              Theme.of(context).textTheme.labelMedium.regular,
          reviewCountTextStyle: Theme.of(context).textTheme.labelSmall.regular,
        );
}
