part of "custom_theme_data.dart";

enum AppColors {
  white(Color(0xFFFFFFFF)),
  black(Color(0xFF000000)),
  primary(Color(0xFF5F0080)),
  onPrimary(Color(0xFFFFFFFF)),
  secondary(Color(0xFFE86C3F)),
  tertiary(Color(0xFF5895C7)),
  onSecondary(Color(0xFFFFFFFF)),
  error(Color(0xFFFF5645)),
  onError(Color(0xFFFFFFFF)),
  background(Color(0xFFFFFFFF)),
  onBackground(Color(0xFF1E1B1E)),
  surface(Color(0xFFF4F4F4)),
  surfaceVariant(Color(0xFFD9D9D9)),
  onSurface(Color(0xFF1E1B1E)),
  onSurfaceVariant(Color.fromRGBO(25, 25, 35, 0.15)),
  primaryContainer(Color(0xFF6F1A8C)),
  secondaryContainer(Color(0xFFD75C2F)),
  tertiaryContainer(Color(0xFF478AC0)),
  inverseSurface(Color.fromRGBO(25, 25, 35, 0.74)),
  inversePrimary(Color.fromRGBO(189, 118, 255, 0.9)),
  onInverseSurface(Color(0xFFDDDDDD)),
  shadow(Color(0xFF000000)),
  outline(Color(0xFFDDDDDD)),
  contentPrimary(Color(0xFF333333)),
  contentSecondary(Color(0xFF666666)),
  contentTertiary(Color(0xFF999999)),
  contentFourth(Color(0xFFB2B2B2)),
  positive(Color(0xFF74CD7C)),
  appbarColor(Color(0xFF3B3050));

  final Color color;

  const AppColors(this.color);
}
