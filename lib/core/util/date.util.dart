import 'package:intl/intl.dart';

class DateUtil {
  String formatDate(DateTime dt) => '${DateFormat('MMM d').format(dt)} ${DateFormat('h:mm a').format(dt)}';
}