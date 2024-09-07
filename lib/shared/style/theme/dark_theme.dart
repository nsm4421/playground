part of 'light_theme.dart';

class CustomDarkTheme extends CustomLightTheme {
  @override
  Brightness get brightness => Brightness.dark;
  @override
  Color get _primary => AppColors.darkTeal;
  @override
  Color get _secondary => AppColors.deepOrangeAccent;
  @override
  Color get _tertiary => AppColors.lightBlueAccent;
  @override
  Color get _background => const Color(0xFF121212);
  @override
  Color get _textColor => const Color(0xFFE0E0E0);

  @override
  Color get _buttonTextColor;

  @override
  ThemeData get _baseTheme => FlexThemeData.dark(
        scheme: FlexScheme.custom,
        colors: FlexSchemeColor.from(
          brightness: Brightness.dark,
          primary: _primary,
          secondary: _secondary,
          tertiary: _tertiary,
          swapOnMaterial3: true,
        ),
        useMaterial3: true,
        useMaterial3ErrorColors: true,
      );

  @override
  TextStyle get _baseTextStyle;

  @override
  ThemeData get theme;
}
