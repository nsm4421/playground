part of '../constant.dart';

enum TappableVariant { normal, faded, scaled }

enum FadeStrength {
  sm(.2),
  md(.4),
  lg(1);

  const FadeStrength(this.strength);

  final double strength;
}

enum ScaleStrength {
  xxxs(0.0325),
  xxs(0.0625),
  xs(0.125),
  sm(0.25),
  lg(0.5),
  xlg(0.75),
  xxlg(1);

  const ScaleStrength(this.strength);

  final double strength;
}
