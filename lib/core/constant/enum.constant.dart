part of 'constant.dart';

enum Status {
  initial,
  loading,
  success,
  error;
}

enum SnackBarType {
  info(bgColor: CustomPalette.darkGrey, textColor: CustomPalette.white),
  warning(bgColor: CustomPalette.mediumGrey, textColor: CustomPalette.white),
  success(bgColor: CustomPalette.positive, textColor: CustomPalette.white),
  error(bgColor: CustomPalette.secondary, textColor: CustomPalette.onSecondary);

  final Color bgColor;
  final Color textColor;

  const SnackBarType({required this.bgColor, required this.textColor});
}
