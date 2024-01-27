import 'package:objectbox/objectbox.dart';
import 'package:questlines/types/quest.dart';

@Entity()
class Stage {
  int id;
  String name = '';
  @Property(type: PropertyType.date)
  DateTime created = DateTime.now();
  bool selected = false;
  bool complete = false;
  final quest = ToOne<Quest>();
  Stage({this.id = 0});
  Stage.withName(this.name, {this.id = 0});
}
