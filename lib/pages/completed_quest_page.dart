// ignore_for_file: must_be_immutable, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:questlines/types/quest.dart';
import 'package:questlines/widgets/quest_card.dart';

class CompletedQuestPage extends StatelessWidget {
  final db;
  const CompletedQuestPage(this.db, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<List<Quest>>(
            stream: db.listenToCompleteQuests(),
            initialData: [],
            builder: (context, snapshot) => ListView(
                  children: snapshot.hasData
                      ? snapshot.data!.map((quest) {
                          return QuestCard(db, quest, true, true);
                        }).toList()
                      : [],
                )));
  }
}
