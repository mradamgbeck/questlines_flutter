// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:questlines/types/quest.dart';
import 'package:questlines/types/stage.dart';
import '../objectbox.g.dart';

class MyAppState extends ChangeNotifier {
  List<Quest> activeQuests = [];
  List<Quest> completedQuests = [];
  late Box questBox;
  late Box stageBox;

  setBoxes(Box questBox, Box stageBox) {
    this.questBox = questBox;
    this.stageBox = stageBox;
  }

  saveQuest(quest) {
    if (quest.stages.length == 0) {
      var defaultStage = Stage.withName(quest.name);
      defaultStage.selected = true;
      quest.stages.add(defaultStage);
    }
    if (activeQuests.contains(quest.id)) {
      activeQuests.remove(quest);
    }
    questBox.put(quest);
    for (var stage in quest.stages) {
      stageBox.put(stage);
    }
    activeQuests.add(quest);
    notifyListeners();
  }

  completeQuest(completedQuest) {
    completedQuest.complete = true;
    completedQuest.selected = false;
    completedQuests.add(completedQuest);
    activeQuests.removeWhere((quest) => quest.id == completedQuest.id);
    questBox.put(completedQuest);
    notifyListeners();
  }

  selectQuest(id) {
    Quest quest = questBox.get(id);
    quest.selected = true;
    questBox.put(quest);
    activeQuests.firstWhere((quest) => quest.id == id).selected = true;
    activeQuests.forEach((quest) => {
          if (quest.id != id) {quest.selected = false}
        });
    notifyListeners();
  }

  getSelectedQuest() {
    Query query = questBox.query(Quest_.selected.equals(true)).build();
    List selectedQuests = query.find();
    query.close();
    if (selectedQuests.isEmpty) {
      return null;
    }
    return selectedQuests[0];
  }

  completeStage(stage) {
    Quest quest = stage.quest;
    stage.complete = true;
    stageBox.put(stage);
    if (quest.isOnLastStage()) {
      completeQuest(quest);
    }
    notifyListeners();
  }

  getSelectedStageForQuest(int id) {
     Query query = stageBox.query(Stage_.quest.equals(id)).build();
    List stages = query.find();
    query.close();
    return stages.firstWhere((stage) => stage.selected);
  }

  List getActiveQuests() {
    Query query = questBox.query(Quest_.complete.equals(false)).build();
    List selectedQuests = query.find();
    query.close();
    return selectedQuests;
  }

  List getCompletedQuests() {
    Query query = questBox.query(Quest_.complete.equals(true)).build();
    List selectedQuests = query.find();
    query.close();
    return selectedQuests;
  }
}
