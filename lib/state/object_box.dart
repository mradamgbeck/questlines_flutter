import 'package:questlines/objectbox.g.dart';
import 'package:questlines/types/quest.dart';
import 'package:questlines/types/stage.dart';

class ObjectBox {
  late final Store store;
  late final Box<Quest> questBox;
  late final Box<Stage> stageBox;

  ObjectBox._create(this.store) {
    questBox = Box<Quest>(store);
    stageBox = Box<Stage>(store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final store = await openStore();
    return ObjectBox._create(store);
  }
}
