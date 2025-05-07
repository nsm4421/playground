import 'package:flutter/material.dart';

import '../../shared/style/generated/assets.gen.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget(
      {super.key, this.width, this.height, required this.fit, this.color});

  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Assets.images.instagramTextLogo.svg(
        fit: fit,
        height: height,
        width: width,
        colorFilter: ColorFilter.mode(
            color ?? Theme.of(context).colorScheme.inversePrimary,
            BlendMode.srcIn));
  }
}
