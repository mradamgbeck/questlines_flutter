// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:questlines/types/quest.dart';
import 'package:questlines/types/stage.dart';
import 'package:questlines/widgets/quest_map.dart';
import 'package:questlines/widgets/quest_card.dart';

class QuestMapPage extends StatefulWidget {
  final db;
  const QuestMapPage(this.db, {super.key});

  @override
  State<QuestMapPage> createState() => _QuestMapPageState();
}

class _QuestMapPageState extends State<QuestMapPage> {
  getSelectedStage(quests) {
    List<Stage> stages = [];
    for (var quest in quests) {
      stages.add(quest.getCurrentStage());
    }
    return stages.isNotEmpty ? stages[0] : null;
  }

  getQuestCards(List<Quest> data) {
    return data.map((quest) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: QuestCard(widget.db, quest, false, true),
      );
    }).toList();
  }

locationCompleteCallback(location){
  setState(() => location.complete = !location.complete);
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<List<Quest>>(
            stream: widget.db.listenToSelectedQuests(),
            initialData: [],
            builder: (context, snapshot) => snapshot.hasData
                ? Stack(
                    children: [
                      QuestMap(widget.db, getSelectedStage(snapshot.data),locationCompleteCallback),
                      Column(
                        children: getQuestCards(snapshot.data!),
                      )
                    ],
                  )
                : QuestMap(widget.db, null, null)),
      ),
    );
  }
}
