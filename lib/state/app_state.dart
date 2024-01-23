// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:questlines/types/quest.dart';
import 'package:collection/collection.dart';

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
    questToSelect.stages[0].selected = true;
    activeQuests.forEach((quest) => {
          if (quest.id != id) {quest.selected = false}
        });
    notifyListeners();
  }

  getSelectedQuest() {
    return activeQuests.firstWhereOrNull((quest) => quest.selected == true);
  }

  completeActiveStage(quest) {
    var currentStageIndex =
        quest.stages.indexWhere((stage) => stage.selected == true);
    var currentStage =
        quest.stages.firstWhere((stage) => stage.selected == true);
    currentStage.complete = true;
    currentStage.selected = false;
    if (currentStageIndex != quest.stages.length - 1) {
      var nextStage = quest.stages[currentStageIndex + 1];
      nextStage.selected = true;
    } else {
      completeQuest(quest);
    }

    notifyListeners();
  }
}
