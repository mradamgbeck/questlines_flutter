import 'package:isar/isar.dart';
import 'package:intl/intl.dart';
part 'stage.g.dart';

@collection
class Stage {
  Id id = Isar.autoIncrement;
  String name = '';
  bool selected = false;
  bool complete = false;
  int questId = 0;
  DateTime? deadline;
  Stage();
  Stage.forQuest(this.questId, this.name);

  getDeadline() {
    return DateFormat('yyyy-MM-dd – kk:mm').format(deadline!);
  }

  getRemainingTime() {
    Duration remaining = deadline!.difference(DateTime.now());
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
}
