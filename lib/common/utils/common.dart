import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/custom/custom_font_weight.dart';
import '../theme/custom/custom_theme.dart';

enum BottomNav { home, category, search, user }

enum MallType { market, beauty }

enum Status { initial, loading, success, error }

enum ViewModuleType {
  viewModuleA,
  viewModuleB,
  viewModuleC,
  viewModuleD,
  viewModuleE,
  carousel_view_module,
  banner_view_module, // 광고 배너
  scroll_view_module
}

extension IntEx on int {
  String krwFormat() => NumberFormat('###,###,###,###원').format(this);

  String overMillion() => (this > 9999) ? '9999+' : this.toString();
}

extension TextStyleEx on TextStyle {
  copyWithTitleTextStyle() => copyWith(
        color: CustomTheme.colorScheme.contentPrimary,
      );

  copyWithPriceTextStyle() => copyWith(
        color: CustomTheme.colorScheme.contentPrimary,
      ).bold;

  copyWithDiscountTextStyle() =>
      copyWith(color: CustomTheme.colorScheme.secondary);

  copyWithOriginalPriceTextStyle() => copyWith(
        color: CustomTheme.colorScheme.contentFourth,
        decoration: TextDecoration.lineThrough,
      );

  copyWithReviewCountTextStyle() =>
      copyWith(color: CustomTheme.colorScheme.contentPrimary);
}
