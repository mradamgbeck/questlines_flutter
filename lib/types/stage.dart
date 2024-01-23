import 'package:uuid/uuid.dart';

class Stage {
  Uuid id = const Uuid();
  String name = '';
  DateTime created = DateTime.now();
  bool selected = false;
  bool complete = false;

  Stage(this.name);
}
