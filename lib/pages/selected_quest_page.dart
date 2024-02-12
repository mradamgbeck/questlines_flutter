// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:questlines/types/quest.dart';
import 'package:questlines/widgets/no_quests_card.dart';
import 'package:questlines/widgets/quest_card.dart';

class SelectedQuestPage extends StatelessWidget {
  final db;

  const SelectedQuestPage(this.db, {super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
        body: StreamBuilder<List<Quest>>(
            stream: db.listenToSelectedQuests(),
            initialData: [],
            builder: (context, snapshot) => ListView(
                  children: snapshot.hasData
                      ? snapshot.data!.map((quest) {
                          return QuestCard(db, quest, false, true);
                        }).toList()
                      : [NoQuestsCard()],
                )));
  }
}
