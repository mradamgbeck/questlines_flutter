// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questlines/state/app_state.dart';
import 'package:questlines/widgets/quest_card.dart';

class CompletedQuestsPage extends StatelessWidget {
  const CompletedQuestsPage({super.key});
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    List<Widget> getQuestWidgets() {
      List quests = appState.completedQuests;
      if (quests.isNotEmpty) {
        return quests
            .map<Widget>((quest) => QuestCard(quest, true, true))
            .toList();
      }
      return [
        SingleChildScrollView(
          child: Column(
            children: const [
              Card(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('No Quests, M\'Lord!', textAlign: TextAlign.center),
              )),
            ],
          ),
        )
      ];
    }

    return ListView(children: getQuestWidgets());
  }
}
