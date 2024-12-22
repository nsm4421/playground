part of '../export.core.dart';

extension DurationNumExtension on num {
  Duration get _unit => Duration(milliseconds: round());
  Duration get ms => (this)._unit;
  Duration get sec => (this * 1000)._unit;
  Duration get min => (this * 1000 * 60)._unit;
  Duration get hour => (this * 1000 * 60 * 60)._unit;
  Duration get day => (this * 1000 * 60 * 60 * 24)._unit;
}

extension IntExtension on int {
  Widget get width => SizedBox(width: toDouble());
  Widget get height => SizedBox(height: toDouble());
}

extension BuildContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;
  EdgeInsets get padding => MediaQuery.of(this).padding;
  Size get size => MediaQuery.of(this).size;
}
