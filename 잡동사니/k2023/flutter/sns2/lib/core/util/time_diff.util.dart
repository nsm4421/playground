class TimeDiffUtil {
  static String getTimeDiffRep(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 1) {
      return "Just now";
    } else if (diff.inHours < 1) {
      return "${diff.inMinutes} min ago";
    } else if (diff.inDays < 1) {
      return "${diff.inHours} hour ago";
    } else {
      return "${diff.inDays} days ago";
    }
  }
}
