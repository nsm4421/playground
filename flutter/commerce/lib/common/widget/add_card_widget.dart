import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/constant/app_colors.dart';
import '../theme/constant/icon_paths.dart';

class AddCardButtonWidget extends StatelessWidget {
  const AddCardButtonWidget({
    super.key,
    opacity = 0.5,
    rightOffset = 8.0,
    bottomOffset = 8.0,
    size = 30.0,
    iconSize = 20.0,
  })  : _opacity = opacity,
        _rightOffset = rightOffset,
        _bottomOffset = bottomOffset,
        _size = size,
        _iconSize = iconSize;

  final double _opacity;
  final double _rightOffset;
  final double _bottomOffset;
  final double _size;
  final double _iconSize;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: _rightOffset,
      bottom: _bottomOffset,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(_opacity),
          shape: BoxShape.circle,
        ),
        width: _size,
        height: _size,
        child: Center(
          child: SvgPicture.asset(
            IconPaths.cart,
            width: _iconSize,
            height: _iconSize,
            colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
