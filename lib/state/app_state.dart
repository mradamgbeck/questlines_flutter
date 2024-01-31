// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:questlines/types/quest.dart';
import 'package:questlines/types/stage.dart';

class MyAppState extends ChangeNotifier {
  late Quest? selectedQuest;
  List activeQuests = [];
  List completedQuests = [];
  late Isar isar;
  late IsarCollection<Quest> questCollection;
  late IsarCollection<Stage> stageCollection;

  bool isInitialized = false;

  Future<void> init() async {
    if (!isInitialized) {
      List<Quest> allQuests = [];
      List<Stage> allStages = [];
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
        [QuestSchema, StageSchema],
        directory: dir.path,
      );
      questCollection = isar.quests;
      stageCollection = isar.stages;
      await isar.txn(() async {
        allQuests = await questCollection.where().findAll();
      });
      await isar.txn(() async {
        allStages = await stageCollection.where().findAll();
      });

      for (var quest in allQuests) {
        quest.stages =
            allStages.where((stage) => stage.questId == quest.id).toList();

        activeQuests = allQuests.where((quest) => !quest.complete).toList();
        completedQuests = allQuests.where((quest) => quest.complete).toList();
      }
      selectedQuest = getSelectedQuest();
      notifyListeners();
      isInitialized = true;
    }
  }

  saveQuest(quest) async {
    if (quest.stages.length == 0) {
      var defaultStage = Stage.forQuest(quest.id, quest.name);
      defaultStage.selected = true;
      quest.stages.add(defaultStage);
    }
    if (activeQuests.contains(quest)) {
      activeQuests.remove(quest);
    }
    await isar.writeTxn(() async {
      int questId = await questCollection.put(quest);
      for (var stage in quest.stages) {
        stage.questId = questId;
        stageCollection.put(stage);
      }
    });

    activeQuests.add(quest);
    notifyListeners();
  }

  completeQuest(completedQuest) async {
    completedQuest.complete = true;
    completedQuest.selected = false;
    completedQuests.add(completedQuest);
    activeQuests.removeWhere((quest) => quest.id == completedQuest.id);
    await isar.writeTxn(() async {
      await questCollection.put(completedQuest);
    });
    notifyListeners();
  }

  toggleSelectQuest(questToToggle) async {
    questToToggle.selected = !questToToggle.selected;
    await isar.writeTxn(() async {
      await questCollection.put(questToToggle);
    });
    activeQuests.forEach((activeQuest) => {
          if (activeQuest.id != questToToggle.id)
            {activeQuest.selected = false, saveQuest(activeQuest)},
        });
    notifyListeners();
  }

  getSelectedQuest() {
    return activeQuests.firstWhereOrNull((quest) => quest.selected);
  }

  completeStage(stage) async {
    Quest quest =
        activeQuests.firstWhere((element) => element.id == stage.questId);
    stage.complete = true;
    stage.selected = false;
    await isar.writeTxn(() async {
      await stageCollection.put(stage);
    });
    if (quest.isOnLastStage()) {
      completeQuest(quest);
    } else {
      quest.currentStage += 1;
      quest.stages[quest.currentStage].selected = true;
      saveQuest(quest);
    }
    notifyListeners();
  }

  getSelectedStageForQuest(quest) {
    return quest.stages.firstWhere((stage) => stage.selected);
  }

  void deleteActiveQuest(quest) {
    if (quest.complete) {
      completedQuests.remove(quest);
    } else {
      activeQuests.remove(quest);
    }
    isar.writeTxn(() => questCollection.delete(quest.id));
    for (var stage in quest.stages) {
      deleteStage(stage);
    }
    notifyListeners();
  }

  void deleteStage(stage) {
    isar.writeTxn(() => stageCollection.delete(stage.id));
    notifyListeners();
  }

  void clearQuests() {
    activeQuests = [];
    completedQuests = [];
    isar.writeTxn(() => questCollection.clear());
    isar.writeTxn(() => stageCollection.clear());
    notifyListeners();
  }

  List getActiveQuestsSorted() {
    activeQuests.sort((a, b) => a.created.compareTo(b.created));
    return activeQuests;
  }
}
