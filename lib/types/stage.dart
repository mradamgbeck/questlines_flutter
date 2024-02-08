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
  Stage();
}
