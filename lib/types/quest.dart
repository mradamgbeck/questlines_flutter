import 'package:questlines/types/stage.dart';
import 'package:isar/isar.dart';
part 'quest.g.dart';

@collection
class Quest {
  Id id = Isar.autoIncrement;
  String name = '';
  bool selected = false;
  bool complete = false;
  @ignore
  List<Stage> stages = [];
  int currentStage = 0;

  Quest();
  Quest.withName(this.name);

  isOnLastStage() {
    return currentStage == stages.length - 1;
  }
}
