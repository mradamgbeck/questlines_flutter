// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:questlines/types/quest.dart';
import 'package:questlines/types/stage.dart';
import 'package:questlines/widgets/quest_map.dart';
import 'package:questlines/widgets/quest_card.dart';

class SelectedQuestPage extends StatelessWidget {
  final db;

  const SelectedQuestPage(this.db, {super.key});
  getSelectedStages(quests) {
    List<Stage> stages = [];
    for (var quest in quests) {
      stages.add(quest.getCurrentStage());
    }
    return stages;
  }

  getQuestCards(List<Quest> data) {
    return data.map((quest) {
      return QuestCard(db, quest, false, true);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Quest>>(
          stream: db.listenToSelectedQuests(),
          initialData: [],
          builder: (context, snapshot) => snapshot.hasData
              ? Stack(
                  children: [
                    Expanded(
                      flex: 4,
                      child: QuestMap(getSelectedStages(snapshot.data))),
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Column(
                          children: getQuestCards(snapshot.data!),
                        ),
                      ),
                    )
                  ],
                )
              : QuestMap([])),
    );
  }
}
