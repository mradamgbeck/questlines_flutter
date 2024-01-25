// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:questlines/types/quest.dart';

class MyAppState extends ChangeNotifier {
  List<Quest> activeQuests = [];
  List<Quest> completedQuests = [];

  addQuest(quest) {
    activeQuests.add(quest);
    notifyListeners();
  }

  completeQuest(completedQuest) {
    completedQuest.complete = true;
    completedQuest.selected = false;
    completedQuests.add(completedQuest);
    activeQuests.removeWhere((quest) => quest.id == completedQuest.id);
    notifyListeners();
  }

  selectQuest(id) {
    var questToSelect = activeQuests.firstWhere((quest) => quest.id == id);
    questToSelect.selected = true;
    activeQuests.forEach((quest) => {
          if (quest.id != id) {quest.selected = false}
        });
    notifyListeners();
  }

  getSelectedQuest() {
    return activeQuests.firstWhereOrNull((quest) => quest.selected == true);
  }

  completeActiveStage(quest) {
    quest.getSelectedStage().complete = true;
    if (quest.isOnLastStage()) {
      completeQuest(quest);
    } else {
      quest.selectedStage += 1;
    }
    notifyListeners();
  }
}
