class GetHumanTime {

  static String getHumanTime(DateTime target) {
      DateTime now = DateTime.now();
      Duration difference = now.difference(target);
      if (difference.inMinutes < 2) {
        return "just now";
      } else if (difference.inHours == 0) {
        return "${difference.inMinutes} mins ago";
      } else if (difference.inDays == 0) {
        return difference.inHours == 1 ? "1 hour ago" : "${difference.inHours} hours ago";
      } else if (difference.inDays < 30) {
        return difference.inDays == 1 ? "1 day ago" : "${difference.inDays} days ago";
      } else if (difference.inDays < 365) {
        int numMonths = (difference.inDays/30).floor();
        return numMonths == 1 ? "1 month ago" : "$numMonths months ago";
      } else {
        int numYears = (difference.inDays/365).floor();
        return numYears == 1 ? "1 year ago" : "$numYears years ago";
      }
  }

}