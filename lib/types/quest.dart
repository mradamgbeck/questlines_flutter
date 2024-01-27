import 'package:objectbox/objectbox.dart';
import 'package:questlines/types/stage.dart';

@Entity()
class Quest {
  int id;
  String name = '';
  @Property(type: PropertyType.date)
  DateTime created = DateTime.now();
  bool selected = false;
  bool complete = false;
  @Backlink()
  final stages = ToMany<Stage>();
  Quest({this.id = 0});

  isOnLastStage() {
    return stages.indexWhere((element) => element.selected) ==
        stages.length - 1;
  }
}
