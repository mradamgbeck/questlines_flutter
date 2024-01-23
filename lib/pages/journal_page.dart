import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questlines/state/app_state.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    getQuestWidgets() {
      return appState.quests
          .map((quest) => Column(
                children: [
                  ElevatedButton.icon(
                      onPressed: () => {appState.selectQuest(quest.id)},
                      icon: const Text('*'),
                      label: Text(quest.name)),
                  for (var stage in quest.stages) Text(stage.name),
                ],
              ))
          .toList();
    }

    return Center(child: ListView(children: getQuestWidgets()));
  }
}
