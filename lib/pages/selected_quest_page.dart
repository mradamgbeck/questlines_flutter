import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questlines/state/app_state.dart';
import 'package:questlines/widgets/quest_card.dart';

class SelectedQuestPage extends StatelessWidget {
  const SelectedQuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var selectedQuest = appState.getSelectedQuest();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          selectedQuest != null
              ? Column(
                  children: [
                    QuestCard(selectedQuest, false, false)
                  ],
                )
              : const Text('No Quest Selected')
        ],
      ),
    );
  }
}
