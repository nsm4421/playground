part of 'util.dart';

mixin class CustomFormatUtil {
  String timeAgoInKr(String timestamp) {
    try {
      final now = DateTime.now();
      final difference = now.difference(DateTime.parse(timestamp));
      if (difference.inSeconds < 60) {
        return '방금 전';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes}분 전';
      } else if (difference.inHours < 24) {
        return '${difference.inHours}시간 전';
      } else if (difference.inDays < 30) {
        return '${difference.inDays}일 전';
      } else if (difference.inDays < 365) {
        return '${(difference.inDays / 30).floor()}개월 전';
      } else {
        return '${(difference.inDays / 365).floor()}년 전';
      }
    } catch (error) {
      return '';
    }
  }
}
