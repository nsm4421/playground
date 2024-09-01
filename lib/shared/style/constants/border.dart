part of '../style.dart';

OutlineInputBorder outlinedBorder({
  double borderRadius = defaultBorderRadius,
  BorderSide? borderSide,
}) =>
    OutlineInputBorder(
      borderSide: borderSide ?? BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    );
