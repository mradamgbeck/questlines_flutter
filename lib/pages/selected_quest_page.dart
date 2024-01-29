// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questlines/state/app_state.dart';
import 'package:questlines/widgets/no_quests_card.dart';
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

    return selectedQuest != null
        ? Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [QuestCard(selectedQuest, false, true)],
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [NoQuestsCard()]);
  }
}
