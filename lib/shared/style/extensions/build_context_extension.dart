part of '../style.dart';

extension BuildContextX on BuildContext {
  Brightness get brightness => theme.brightness;

  bool get isLight => brightness == Brightness.light;

  bool get isDark => !isLight;

  Color get adaptiveColor => isDark ? AppColors.white : AppColors.black;

  Color get reversedAdaptiveColor => isDark ? AppColors.black : AppColors.white;

  Color customAdaptiveColor({Color? light, Color? dark}) =>
      isDark ? (light ?? AppColors.white) : (dark ?? AppColors.black);

  Color customReversedAdaptiveColor({Color? light, Color? dark}) =>
      isDark ? (dark ?? AppColors.black) : (light ?? AppColors.white);

  Size get size => MediaQuery.sizeOf(this);

  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);

  double get screenWidth => size.width;

  double get screenHeight => size.height;

  double get devicePixelRatio => MediaQuery.devicePixelRatioOf(this);

  bool get isAndroid => theme.platform == TargetPlatform.android;

  bool get isIOS => !isAndroid;

  bool get isMobile => isAndroid || isIOS;
}
