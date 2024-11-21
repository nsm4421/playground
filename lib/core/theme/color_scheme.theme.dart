part of 'theme.dart';

class CustomColorScheme extends ColorScheme {
  const CustomColorScheme({
    super.brightness = Brightness.light,
    super.primary = CustomPalette.primary,
    super.onPrimary = CustomPalette.onPrimary,
    super.secondary = CustomPalette.secondary,
    super.onSecondary = CustomPalette.onSecondary,
    super.tertiary = CustomPalette.tertiary,
    super.onTertiary = CustomPalette.onTertiary,
    super.error = CustomPalette.error,
    super.onError = CustomPalette.onError,
    super.surface = CustomPalette.surface,
    super.onSurface = CustomPalette.onSurface,
    super.onSurfaceVariant = CustomPalette.onSurfaceVariant,
    super.outline = CustomPalette.outline,
    super.shadow = CustomPalette.shadow,
    super.inverseSurface = CustomPalette.inverseSurface,
    super.onInverseSurface = CustomPalette.onInverseSurface,
    super.inversePrimary = CustomPalette.inversePrimary,
  });

  // TODO : 다크모드 정의하기
  const CustomColorScheme.dark({
    super.brightness = Brightness.dark,
  }) : super.dark();
}
