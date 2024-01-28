import 'package:isar/isar.dart';
part 'stage.g.dart';

@collection
 class Stage {
  Id id = Isar.autoIncrement;
  String name = '';
  bool selected = false;
  bool complete = false;
  int questId = 0;

  Stage();
  Stage.forQuest(this.questId, this.name);
}
