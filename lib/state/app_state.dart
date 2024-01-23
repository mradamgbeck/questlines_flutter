// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:questlines/types/quest.dart';
import 'package:collection/collection.dart';

class MyAppState extends ChangeNotifier {
  List<Quest> quests = [];
  addQuest(quest) {
    quests.add(quest);
    notifyListeners();
  }

  selectQuest(id) {
    var questToSelect = quests.firstWhere((quest) => quest.id == id);
    questToSelect.selected = true;
    questToSelect.stages[0].selected = true;
    quests.forEach((quest) => {
          if (quest.id != id) {quest.selected = false}
        });
    notifyListeners();
  }

  getSelectedQuest() {
    return quests.firstWhereOrNull((quest) => quest.selected == true);
  }
}
