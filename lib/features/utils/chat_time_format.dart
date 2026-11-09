/// Short timestamp labels for the chat list: "14:05" today, "Yesterday",
/// a weekday name within the last week, otherwise "day/month".
///
/// Compares calendar dates rather than 24-hour periods, so a message from
/// 23:00 yesterday reads "Yesterday" even when it's only a few hours old.
String formatChatListTime(DateTime? time, {DateTime? now}) {
  if (time == null) return '';
  final current = now ?? DateTime.now();
  final today = DateTime(current.year, current.month, current.day);
  final day = DateTime(time.year, time.month, time.day);
  final daysAgo = today.difference(day).inDays;

  if (daysAgo <= 0) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }
  if (daysAgo == 1) return 'Yesterday';
  if (daysAgo < 7) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[time.weekday - 1];
  }
  return '${time.day}/${time.month}';
}
