part of 'extension.dart';

extension DurationNumExtension on num {
  Duration get _unit => Duration(milliseconds: round());

  Duration get ms => (this * 1000)._unit;

  Duration get sec => (this * 1000 * 1000)._unit;

  Duration get min => (this * 1000 * 1000 * 60)._unit;

  Duration get hour => (this * 1000 * 1000 * 60 * 60)._unit;

  Duration get day => (this * 1000 * 1000 * 60 * 60 * 24)._unit;
}
