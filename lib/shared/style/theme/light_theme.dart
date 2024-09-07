import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import '../size/custom_size.dart';

part 'dark_theme.dart';

class CustomLightTheme {
  // 밝기
  Brightness get brightness => Brightness.light;

  // 색깔
  Color get _primary => Colors.black87;
  Color get _secondary => Colors.black38;
  Color get _tertiary => Colors.blueGrey;

  Color get _background => const Color.fromARGB(255, 8, 53, 16);
  Color get _textColor => const Color(0xFF212121);
  Color get _buttonTextColor => Colors.white;

  // 기본 테마
  ThemeData get _baseTheme => FlexThemeData.light(
        scheme: FlexScheme.custom,
        colors: FlexSchemeColor.from(
          brightness: Brightness.light,
          primary: _primary,
          secondary: _secondary,
          tertiary: _tertiary,
          swapOnMaterial3: true,
        ),
        useMaterial3: true,
        useMaterial3ErrorColors: true,
      );

  // 기본 텍스트 스타일
  TextStyle get _baseTextStyle => TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
      fontSize: CustomTextSize.md,
      color: _textColor,
      decoration: TextDecoration.none,
      textBaseline: TextBaseline.alphabetic,
      decorationThickness: 0);

  // 테마
  ThemeData get theme => _baseTheme.copyWith(
      textTheme: TextTheme(
          headlineLarge: _baseTextStyle.copyWith(
            fontSize: CustomTextSize.lg * 2,
            fontWeight: FontWeight.w900,
            height: 1.22,
          ),
          headlineMedium: _baseTextStyle.copyWith(
            fontSize: CustomTextSize.lg * 1.8,
            fontWeight: FontWeight.w900,
            height: 1.25,
          ),
          headlineSmall: _baseTextStyle.copyWith(
            fontSize: CustomTextSize.lg * 1.5,
            fontWeight: FontWeight.w800,
            height: 1.28,
          ),
          bodyLarge: _baseTextStyle.copyWith(
            fontSize: CustomTextSize.lg * 1.3,
            height: 1.5,
            letterSpacing: 0.5,
          ),
          bodyMedium: _baseTextStyle.copyWith(
            fontSize: CustomTextSize.lg,
            height: 1.42,
            letterSpacing: 0.25,
          ),
          bodySmall: _baseTextStyle.copyWith(
            fontSize: CustomTextSize.lg * 0.8,
            height: 1.33,
            letterSpacing: 0.4,
          ),
          labelLarge: _baseTextStyle.copyWith(
            fontSize: CustomTextSize.lg * 0.6,
            height: 1.4,
            letterSpacing: 0.4,
          ),
          labelMedium: _baseTextStyle.copyWith(
            fontSize: CustomTextSize.lg * 0.5,
            height: 1.2,
            letterSpacing: 0.3,
          ),
          labelSmall: _baseTextStyle.copyWith(
            fontSize: CustomTextSize.lg * 0.4,
            height: 1,
            letterSpacing: 0.2,
          )).apply(
        bodyColor: _textColor,
        displayColor: _textColor,
        decorationColor: _textColor,
      ),
      iconTheme: IconThemeData(color: _textColor, size: CustomSpacing.lg),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: CustomSpacing.sm),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          counterStyle: _baseTextStyle.copyWith(
              fontSize: CustomTextSize.sm,
              height: 1,
              color: _textColor.withOpacity(0.8))),
      appBarTheme: AppBarTheme(
        elevation: 0,
        surfaceTintColor: _background,
        backgroundColor: _background,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        showDragHandle: true,
        surfaceTintColor: _textColor,
        backgroundColor: _textColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(_primary),
          foregroundColor: WidgetStateProperty.all<Color>(_buttonTextColor),
          padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
              horizontal: CustomSpacing.lg, vertical: CustomSpacing.tiny)),
          textStyle: WidgetStateProperty.all<TextStyle>(_baseTextStyle.copyWith(
              fontSize: 18,
              letterSpacing: 0.8,
              color: _textColor,
              fontWeight: FontWeight.bold)),
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return _background;
              }
              return null;
            },
          ),
        ),
      ));
}
