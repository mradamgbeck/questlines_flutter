// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questlines/state/app_state.dart';
import 'package:questlines/widgets/quest_card.dart';

class SelectedQuestPage extends StatefulWidget {
  const SelectedQuestPage({super.key});

  @override
  State<SelectedQuestPage> createState() => _SelectedQuestPageState();
}

class _SelectedQuestPageState extends State<SelectedQuestPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    late var selectedQuest = appState.getSelectedQuest();

    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            selectedQuest != null
                ? Column(
                    children: [QuestCard(selectedQuest, false, true)],
                  )
                : Card(
                    child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('No Quests, M\'Lord!'),
                  )),
          ],
        ),
      ),
    );
  }
}
