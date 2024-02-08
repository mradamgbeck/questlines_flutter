// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:questlines/types/quest.dart';
import 'package:questlines/types/stage.dart';

class Database {
  late Future<Isar> isar;

  Database() {
    isar = openDb();
  }

  Future<Isar> openDb() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationSupportDirectory();
      return await Isar.open(
        [QuestSchema, StageSchema],
        inspector: true,
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> saveQuest(Quest quest) async {
    final db = await isar;
    db.writeTxnSync<int>(() => db.quests.putSync(quest));
  }

  getSelectedQuest() async {
    final db = await isar;
    return db.quests.filter().selectedEqualTo(true);
  }

  getActiveQuests() async {
    final db = await isar;
    return db.quests.filter().completeEqualTo(false);
  }

  Stream<List<Quest>> listenToSelectedQuests() async* {
    final db = await isar;
    yield* db.quests
        .filter()
        .selectedEqualTo(true)
        .watch(fireImmediately: true);
  }

  Stream<List<Quest>> listenToActiveQuests() async* {
    final db = await isar;
    yield* db.quests
        .filter()
        .completeEqualTo(false)
        .watch(fireImmediately: true);
  }

  Stream<List<Quest>> listenToCompleteQuests() async* {
    final db = await isar;
    yield* db.quests
        .filter()
        .completeEqualTo(true)
        .watch(fireImmediately: true);
  }

  getCompletedQuests() async {
    final db = await isar;
    return db.quests.filter().completeEqualTo(true);
  }

  toggleSelectQuest(questToToggle) async {
    questToToggle.selected = !questToToggle.selected;
    saveQuest(questToToggle);
  }

  advanceQuestStage(quest) async {
    final db = await isar;
    List<Stage> stages = quest.getStagesSorted();
    Stage currentStage = quest.getCurrentStage();
    if (quest.isOnLastStage()) {
      completeQuest(quest);
    } else {
      Stage nextStage = stages.elementAt(currentStage.priority + 1);
      nextStage.selected = true;
      await db.writeTxn(() async => await db.stages.put(nextStage));
    }
    currentStage.selected = false;
    currentStage.complete = true;
    await db.writeTxn(() async => await db.stages.put(currentStage));
    await db.writeTxn(() async => await db.quests.put(quest));
  }

  completeQuest(completedQuest) async {
    final db = await isar;
    completedQuest.complete = true;
    completedQuest.selected = false;
    await db.writeTxn(() async {
      await db.quests.put(completedQuest);
    });
  }

  deleteQuest(quest) async {
    final db = await isar;
    db.writeTxn(() => db.quests.delete(quest.id));
  }

  clearQuests() async {
    final db = await isar;
    db.writeTxn(() => db.quests.clear());
    db.writeTxn(() => db.stages.clear());
  }

  saveStage(stage) async {
    final db = await isar;
    db.writeTxnSync(() => db.stages.put(stage));
  }

  completeStage(stage) async {
    var quest = stage.quest.value;
    advanceQuestStage(quest);
  }

  Future<void> deleteStage(stage) async {
    final db = await isar;
    db.writeTxnSync(() => db.stages.delete(stage.id));
  }
}
