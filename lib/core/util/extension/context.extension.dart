part of 'extension.dart';

extension BuildContextExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  Size get size => MediaQuery.of(this).size;

  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;

  double get width => size.width;

  double get height => size.height;
}
