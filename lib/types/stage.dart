import 'package:uuid/uuid.dart';

class Stage {
  Uuid id = const Uuid();
  String name = '';
  DateTime created = DateTime.now();
  bool complete = false;

  Stage(this.name);
}
