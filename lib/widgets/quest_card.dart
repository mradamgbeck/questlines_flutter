import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questlines/state/app_state.dart';
import '../types/quest.dart';

class QuestCard extends StatelessWidget {
  final Quest quest;
  final bool displayStages;
  const QuestCard(this.quest, this.displayStages, {super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    ListTile getQuestTile() {
      return quest.complete
          ? ListTile(
              leading: const Icon(Icons.done),
              title: Text(quest.name),
            )
          : ListTile(
              leading: const Icon(Icons.map),
              title: Text(quest.name),
              subtitle: CheckboxListTile(
                  title: Text(quest.getSelectedStage().name),
                  value: quest.getSelectedStage().complete,
                  onChanged: (value) => {appState.completeActiveStage(quest)}),
            );
    }

    List<Widget> getOptionButtons() {
      return <Widget>[
        if (!quest.complete && !quest.selected)
          TextButton(
            child: const Text('Select'),
            onPressed: () => {appState.selectQuest(quest.id)},
          ),
        const SizedBox(width: 8),
        if (!quest.complete)
          TextButton(
            child: const Text('View / Edit'),
            onPressed: () {/* ... */},
          ),
        const SizedBox(width: 8),
      ];
    }

    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          getQuestTile(),
          if (displayStages)
            for (var stage in quest.stages) Text(stage.name),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: getOptionButtons(),
          ),
        ],
      ),
    );
  }
}
