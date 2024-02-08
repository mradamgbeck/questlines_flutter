import 'package:questlines/types/stage.dart';
import 'package:isar/isar.dart';
part 'quest.g.dart';

@collection
class Quest {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
  String name = '';

  bool selected = false;
  bool complete = false;

  @Index()
  int created = DateTime.timestamp().millisecondsSinceEpoch;

  @Backlink(to: 'quest')
  final stages = IsarLinks<Stage>();

  Quest();

  bool isOnLastStage() {
    return getStagesSorted()
        .indexWhere((stage) => stage.selected) ==
        stages.length - 1;
  }

  Stage getCurrentStage() {
    return stages.toList().firstWhere((stage) => stage.selected);
  }

  List<Stage> getStagesSorted() {
    return stages.toList()..sort((a, b) => a.priority.compareTo(b.priority));
  }
}
