import 'package:intl/intl.dart';

formatDateTime(deadline) {
  return DateFormat('yyyy-MM-dd – kk:mm').format(deadline);
}

getRemainingTime(deadline) {
  Duration remaining = deadline.difference(DateTime.now());
  double years = remaining.inDays / 365;
  int days = remaining.inDays;
  int hours = remaining.inHours;
  int minutes = remaining.inMinutes;
  int seconds = remaining.inSeconds;
  return (years > 0.49
      ? '${years.toStringAsFixed(1)} years'
      : (days >= 1)
          ? '$days days'
          : (24 > hours && hours >= 1)
              ? '${hours.toStringAsFixed(1)} hours'
              : (60 > minutes && minutes > 1)
                  ? '${minutes.toStringAsFixed(1)} minutes'
                  : (seconds > 0)
                      ? '$seconds seconds'
                      : 'Failed');
}
