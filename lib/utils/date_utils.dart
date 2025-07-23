bool isToday(DateTime date) {
  final now = DateTime.now();
  return now.year == date.year &&
      now.month == date.month &&
      now.day == date.day;
}

String formatDate(DateTime date) {
  return "${date.day}/${date.month}/${date.year}";
}
