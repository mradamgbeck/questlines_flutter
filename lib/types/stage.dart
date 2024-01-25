import 'package:uuid/uuid.dart';

class Stage {
  String id = const Uuid().v4();
  String name = '';
  DateTime created = DateTime.now();
  bool complete = false;

  Stage(this.name);
}
