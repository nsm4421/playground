import 'package:intl/intl.dart';

class DateFormatUtils {
  static String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final dt = now.difference(dateTime);
    if (dt.inSeconds < 60) {
      return "${dt.inSeconds} 초 전";
    } else if (dt.inMinutes < 60) {
      return "${dt.inMinutes} 분 전";
    } else if (dt.inHours < 24) {
      return "${dt.inHours} 시간 전";
    } else if (dt.inDays < 7) {
      return "${dt.inDays} 일 전";
    } else {
      final formattedDate = DateFormat('yyyy.MM.dd HH:mm').format(dateTime);
      return formattedDate;
    }
  }
}
