part of '../style.dart';

@lazySingleton
class CustomLightTheme {
  const CustomLightTheme();

  Brightness get brightness => Brightness.light;

  Color get backgroundColor => AppColors.white;

  Color get primary => AppColors.black;

  ThemeData get theme => FlexThemeData.light(
        scheme: FlexScheme.custom,
        colors: FlexSchemeColor.from(
          brightness: brightness,
          primary: primary,
          swapOnMaterial3: true,
        ),
        useMaterial3: true,
        useMaterial3ErrorColors: true,
      ).copyWith(
        textTheme: const CustomLightTheme().textTheme,
        iconTheme: const IconThemeData(color: AppColors.black),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          surfaceTintColor: AppColors.white,
          backgroundColor: AppColors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          showDragHandle: true,
          surfaceTintColor: AppColors.white,
          backgroundColor: AppColors.white,
        ),
      );

  TextTheme get textTheme => contentTextTheme;

  static final contentTextTheme = TextTheme(
    displayLarge: ContentTextStyle.headline1,
    displayMedium: ContentTextStyle.headline2,
    displaySmall: ContentTextStyle.headline3,
    headlineLarge: ContentTextStyle.headline4,
    headlineMedium: ContentTextStyle.headline5,
    headlineSmall: ContentTextStyle.headline6,
    titleLarge: ContentTextStyle.headline7,
    titleMedium: ContentTextStyle.subtitle1,
    titleSmall: ContentTextStyle.subtitle2,
    bodyLarge: ContentTextStyle.bodyText1,
    bodyMedium: ContentTextStyle.bodyText2,
    labelLarge: ContentTextStyle.button,
    bodySmall: ContentTextStyle.caption,
    labelSmall: ContentTextStyle.overline,
  ).apply(
    bodyColor: AppColors.black,
    displayColor: AppColors.black,
    decorationColor: AppColors.black,
  );

  static final uiTextTheme = TextTheme(
    displayLarge: UITextStyle.headline1,
    displayMedium: UITextStyle.headline2,
    displaySmall: UITextStyle.headline3,
    headlineMedium: UITextStyle.headline4,
    headlineSmall: UITextStyle.headline5,
    titleLarge: UITextStyle.headline6,
    titleMedium: UITextStyle.subtitle1,
    titleSmall: UITextStyle.subtitle2,
    bodyLarge: UITextStyle.bodyText1,
    bodyMedium: UITextStyle.bodyText2,
    labelLarge: UITextStyle.button,
    bodySmall: UITextStyle.caption,
    labelSmall: UITextStyle.overline,
  ).apply(
    bodyColor: AppColors.black,
    displayColor: AppColors.black,
    decorationColor: AppColors.black,
  );
}

@lazySingleton
class CustomDarkTheme extends CustomLightTheme {
  const CustomDarkTheme();

  @override
  Brightness get brightness => Brightness.dark;

  @override
  Color get backgroundColor => AppColors.black;

  @override
  Color get primary => AppColors.white;

  @override
  TextTheme get textTheme {
    return CustomLightTheme.contentTextTheme.apply(
      bodyColor: AppColors.white,
      displayColor: AppColors.white,
      decorationColor: AppColors.white,
    );
  }

  @override
  ThemeData get theme => FlexThemeData.dark(
        scheme: FlexScheme.custom,
        darkIsTrueBlack: true,
        colors: FlexSchemeColor.from(
          brightness: brightness,
          primary: primary,
          appBarColor: AppColors.transparent,
          swapOnMaterial3: true,
        ),
        useMaterial3: true,
        useMaterial3ErrorColors: true,
      ).copyWith(
        textTheme: const CustomDarkTheme().textTheme,
        iconTheme: const IconThemeData(color: AppColors.white),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.black,
          surfaceTintColor: AppColors.black,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          surfaceTintColor: AppColors.background,
          backgroundColor: AppColors.background,
          modalBackgroundColor: AppColors.background,
        ),
      );
}
