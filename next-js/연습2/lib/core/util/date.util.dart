import 'package:timeago/timeago.dart' as timeago;

extension DateTimeExt on DateTime {
  format({String? locale, DateTime? clock, bool allowFromNow = false}) =>
      timeago.format(this, locale: locale, allowFromNow: allowFromNow);
}
