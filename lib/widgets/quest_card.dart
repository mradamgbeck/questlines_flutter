import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questlines/state/app_state.dart';
import '../types/quest.dart';

class QuestCard extends StatelessWidget {
  final Quest quest;
  final bool isListPage;
  const QuestCard(this.quest, this.isListPage, {super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    ListTile getQuestTile() {
      return isListPage
          ? ListTile(
              leading: const Icon(Icons.done),
              title: Text(quest.name),
            )
          : ListTile(
              leading: const Icon(Icons.map),
              title: Text(quest.name),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(quest.getSelectedStage().name),
                  TextButton(
                    child: Text('Done'),
                    onPressed: () => {appState.completeActiveStage(quest)},
                  )
                ],
              ));
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
          if (isListPage)
            for (var stage in quest.stages)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  stage.complete ? Icon(Icons.done) : Icon(Icons.arrow_right),
                  Text(stage.name)
                ],
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: getOptionButtons(),
          ),
        ],
      ),
    );
  }
}
