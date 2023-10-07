import 'package:flutter/material.dart';

import '../theme/custom/custom_font_weight.dart';
import '../theme/custom/custom_theme.dart';

class ViewModuleTitleWidget extends StatelessWidget {
  const ViewModuleTitleWidget({super.key, required this.title});

  static const double _paddingTop = 24;
  static const double _paddingHorizontal = 15;
  static const double _paddingBottom = 8;

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          left: _paddingHorizontal,
          top: _paddingTop,
          right: _paddingHorizontal,
          bottom: _paddingBottom,
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge.semiBold?.copyWith(
                color: Theme.of(context).colorScheme.contentPrimary,
              ),
        ),
      );
}
