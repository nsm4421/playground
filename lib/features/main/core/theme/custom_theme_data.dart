import 'package:flutter/material.dart';

part 'app_color.dart';

part 'font_weight.dart';

class CustomThemeData {
  static ThemeData get themeData => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: AppColors.primary.color,
            onPrimary: AppColors.onPrimary.color,
            primaryContainer: AppColors.primaryContainer.color,
            secondary: AppColors.secondary.color,
            onSecondary: AppColors.onSecondary.color,
            tertiary: AppColors.tertiary.color,
            tertiaryContainer: AppColors.tertiaryContainer.color,
            error: AppColors.error.color,
            onError: AppColors.onError.color,
            background: AppColors.background.color,
            onBackground: AppColors.onBackground.color,
            surface: AppColors.surface.color,
            onSurface: AppColors.onSurface.color,
            surfaceVariant: AppColors.surfaceVariant.color,
            onSurfaceVariant: AppColors.onSurfaceVariant.color,
            outline: AppColors.outline.color,
            shadow: AppColors.shadow.color,
            inverseSurface: AppColors.inverseSurface.color,
            onInverseSurface: AppColors.onInverseSurface.color,
            inversePrimary: AppColors.inversePrimary.color),
        fontFamily: 'Pretendard',
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: AppColors.black.color,
            fontSize: 57,
            fontWeight: FontWeights.regular.weight,
            height: 68 / 57,
          ),
          displayMedium: TextStyle(
            color: AppColors.black.color,
            fontSize: 45,
            fontWeight: FontWeights.regular.weight,
            height: 54 / 45,
          ),
          displaySmall: TextStyle(
            color: AppColors.black.color,
            fontSize: 36,
            fontWeight: FontWeights.regular.weight,
            letterSpacing: -0.35,
            height: 45 / 36,
          ),
          headlineLarge: TextStyle(
            color: AppColors.black.color,
            fontSize: 32,
            fontWeight: FontWeights.semiBold.weight,
            height: 40 / 32,
          ),
          headlineMedium: TextStyle(
            color: AppColors.black.color,
            fontSize: 22,
            fontWeight: FontWeights.semiBold.weight,
            height: 28 / 22,
          ),
          headlineSmall: TextStyle(
            color: AppColors.black.color,
            fontSize: 20,
            fontWeight: FontWeights.regular.weight,
            letterSpacing: -0.35,
            height: 25 / 20,
          ),
          titleLarge: TextStyle(
            color: AppColors.black.color,
            fontSize: 18,
            fontWeight: FontWeights.regular.weight,
            letterSpacing: -0.35,
            height: 23 / 18,
          ),
          titleMedium: TextStyle(
            color: AppColors.black.color,
            fontSize: 16,
            fontWeight: FontWeights.regular.weight,
            letterSpacing: 0.1,
            height: 20 / 16,
          ),
          titleSmall: TextStyle(
            color: AppColors.black.color,
            fontSize: 14,
            fontWeight: FontWeights.regular.weight,
            letterSpacing: 0.12,
            height: 18 / 14,
          ),
          bodyLarge: TextStyle(
            color: AppColors.black.color,
            fontSize: 16,
            fontWeight: FontWeights.regular.weight,
            letterSpacing: 0.5,
            height: 24 / 16,
          ),
          bodyMedium: TextStyle(
            color: AppColors.black.color,
            fontSize: 14,
            fontWeight: FontWeights.regular.weight,
            letterSpacing: 0.25,
            height: 21 / 14,
          ),
          bodySmall: TextStyle(
            color: AppColors.black.color,
            fontSize: 12,
            fontWeight: FontWeights.regular.weight,
            letterSpacing: 0.4,
            height: 18 / 12,
          ),
          labelLarge: TextStyle(
            color: AppColors.black.color,
            fontSize: 13,
            fontWeight: FontWeights.regular.weight,
            letterSpacing: 0.5,
            height: 16 / 13,
          ),
          labelMedium: TextStyle(
            color: AppColors.black.color,
            fontSize: 12,
            fontWeight: FontWeights.regular.weight,
            letterSpacing: 0.25,
            height: 15 / 12,
          ),
          labelSmall: TextStyle(
            color: AppColors.black.color,
            fontSize: 11,
            fontWeight: FontWeights.regular.weight,
            height: 15 / 11,
          ),
        ),
        dividerTheme: DividerThemeData(color: AppColors.outline.color),
        appBarTheme: AppBarTheme(
            color: AppColors.appbarColor.color,
            titleTextStyle: TextStyle(
                color: AppColors.white.color,
                fontSize: 18,
                fontWeight: FontWeights.bold.weight),
            iconTheme: IconThemeData(color: AppColors.white.color)),
        tabBarTheme: TabBarTheme(
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: AppColors.primary.color, width: 2),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: AppColors.primary.color,
          unselectedLabelColor: AppColors.contentSecondary.color,
          overlayColor: WidgetStatePropertyAll<Color>(
            Colors.grey[300] ?? Colors.grey,
          ),
        ),
      );
}
