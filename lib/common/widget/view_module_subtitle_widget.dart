import 'package:flutter/material.dart';

import '../theme/custom/custom_theme.dart';

class ViewModuleSubtitleWidget extends StatelessWidget {
  const ViewModuleSubtitleWidget({super.key, required this.subtitle});

  static const double _paddingBottom = 24;
  static const double _horizontalPadding = 15;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          left: _horizontalPadding,
          right: _horizontalPadding,
          bottom: _paddingBottom,
        ),
        child: Text(
          subtitle,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.contentTertiary,
              ),
        ),
      );
}
