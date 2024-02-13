import 'package:isar/isar.dart';
import 'package:questlines/types/quest.dart';
part 'stage.g.dart';

@collection
class Stage {
  @Index()
  Id id = Isar.autoIncrement;
  String name = '';
  int priority = 0;
  bool selected = false;
  bool complete = false;
  final quest = IsarLink<Quest>();
  DateTime? deadline;
  double? latitude;
  double? longitude;

  Stage();

  bool hasLocation() {
    if (latitude == null || longitude == null) {
      return false;
    } else if (latitude!.isNaN & longitude!.isNaN) {
      return false;
    }
    return true;
  }
}
