import 'package:flutter/material.dart';

extension ExtendedTheme on BuildContext {
  CustomThemeExtension get theme {
    return Theme.of(this).extension<CustomThemeExtension>()!;
  }
}

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  final Color? elevatedButtonTextColor;

  const CustomThemeExtension({
    this.elevatedButtonTextColor,
  });

  static const lightMode = CustomThemeExtension(
    elevatedButtonTextColor: Colors.white54,
  );

  static const darkMode = CustomThemeExtension(
    elevatedButtonTextColor: Colors.white,
  );

  @override
  ThemeExtension<CustomThemeExtension> copyWith({
    Color? elevatedButtonTextColor,
  }) {
    return CustomThemeExtension(
        elevatedButtonTextColor:
            elevatedButtonTextColor ?? this.elevatedButtonTextColor);
  }

  @override
  ThemeExtension<CustomThemeExtension> lerp(
      ThemeExtension<CustomThemeExtension>? other, double t) {
    if (other is! CustomThemeExtension) return this;
    return CustomThemeExtension(
      elevatedButtonTextColor:
          Color.lerp(elevatedButtonTextColor, other.elevatedButtonTextColor, t),
    );
  }
}
