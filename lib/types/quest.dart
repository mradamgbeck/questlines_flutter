import 'package:questlines/types/stage.dart';
import 'package:uuid/uuid.dart';

class Quest {
  String id = const Uuid().v4();
  String name = '';
  List<Stage> stages = [];
  DateTime created = DateTime.now();
  bool selected = false;
  bool complete = false;

  Quest(this.name);
  addStage(stageName) {
    stages.add(Stage(stageName));
  }

  removeStage(uuid) {
    stages.removeWhere((element) => element.id == uuid);
  }

  getSelectedStage(){
    return stages.firstWhere((stage) => stage.selected);
  }
}
