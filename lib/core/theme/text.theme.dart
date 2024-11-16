part of 'theme.dart';

class CustomTextTheme extends TextTheme {
  @override
  TextStyle? get displayLarge => const TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.w800,
      height: (72 + 12) / 72,
      decorationThickness: 0);

  @override
  TextStyle? get displayMedium => const TextStyle(
      fontSize: 66,
      fontWeight: FontWeight.w800,
      height: (66 + 12) / 66,
      decorationThickness: 0);

  @override
  TextStyle? get displaySmall => const TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.5,
      height: (60 + 12) / 60,
      decorationThickness: 0);

  @override
  TextStyle? get headlineLarge => const TextStyle(
        fontSize: 52,
        fontWeight: FontWeight.w700,
        height: (52 + 8) / 52,
        decorationThickness: 0,
      );

  @override
  TextStyle? get headlineMedium => const TextStyle(
        fontSize: 44,
        fontWeight: FontWeight.w700,
        height: (44 + 8) / 44,
        decorationThickness: 0,
      );

  @override
  TextStyle? get headlineSmall => const TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.35,
        height: (36 + 8) / 36,
      );

  @override
  TextStyle? get titleLarge => const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        height: (30 + 5) / 30,
        decorationThickness: 0,
      );

  @override
  TextStyle? get titleMedium => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: (24 + 5) / 24,
        decorationThickness: 0,
      );

  @override
  TextStyle? get titleSmall => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.12,
        height: (18 + 5) / 18,
        decorationThickness: 0,
      );

  @override
  TextStyle? get bodyLarge => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: (24 + 4) / 24,
        decorationThickness: 0,
      );

  @override
  TextStyle? get bodyMedium => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.25,
        height: (18 + 4) / 18,
        decorationThickness: 0,
      );

  @override
  TextStyle? get bodySmall => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
        height: (12 + 4) / 12,
      );

  @override
  TextStyle? get labelLarge => const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: (15 + 3) / 15,
        decorationThickness: 0,
      );

  @override
  TextStyle? get labelMedium => const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: (13 + 3) / 13,
      );

  @override
  TextStyle? get labelSmall => const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: (11 + 3) / 11,
        decorationThickness: 0,
      );
}
