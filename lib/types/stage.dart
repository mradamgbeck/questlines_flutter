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
  List<StageLocation> locations = [];

  Stage();

  bool hasLocation() {
    return locations.isNotEmpty;
  }

  int getCompleteLocationAmount() {
    return locations.where((element) => element.complete).toList().length;
  }

  getCompletedLocationFraction(){
    return "${getCompleteLocationAmount()}/${locations.length}";
  }
}

@embedded
class StageLocation {
  StageLocation([this.latitude, this.longitude]);
  double? latitude;
  double? longitude;
  bool complete = false;
}
