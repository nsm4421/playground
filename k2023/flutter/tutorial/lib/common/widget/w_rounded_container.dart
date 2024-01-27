import 'package:fast_app_base/common/common.dart';
import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final Color? color;

  const RoundedContainer(
      {super.key,
      required this.child,
      this.padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      this.radius = 20,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? context.appColors.roundedLayoutBackground,
        borderRadius: BorderRadius.circular(radius)
      ),
      child: child,
    );
  }
}
