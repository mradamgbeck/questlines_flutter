import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questlines/pages/edit_quest_page.dart';
import 'package:questlines/state/app_state.dart';
import 'package:questlines/types/stage.dart';
import '../types/quest.dart';

class QuestCard extends StatelessWidget {
  final Quest quest;
  final bool isListPage;
  final bool displayOnly;

  const QuestCard(this.quest, this.isListPage, this.displayOnly, {super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    ListTile getQuestTile() {
      int selectedStage = appState.getSelectedStageForQuest(quest.id);
      return isListPage
          ? ListTile(
              leading: getQuestIcon(),
              title: Text(quest.name),
            )
          : ListTile(
              leading: getQuestIcon(),
              title: Text(quest.name),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(selectedStage.name),
                  TextButton(
                    child: Text('Done'),
                    onPressed: () => {appState.completeStage(selectedStage)},
                  )
                ],
              ));
    }

    List<Widget> getOptionButtons() {
      return !displayOnly
          ? <Widget>[
              if (!quest.complete && !quest.selected)
                TextButton(
                  child: const Text('Select'),
                  onPressed: () => {appState.selectQuest(quest.id)},
                ),
              const SizedBox(width: 8),
              if (!quest.complete)
                TextButton(
                  child: const Text('Edit'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditQuestPage.withQuest(quest)));
                  },
                ),
              const SizedBox(width: 8),
            ]
          : <Widget>[];
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
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(stage.name),
                  )
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

  Icon getQuestIcon() => quest.complete ? Icon(Icons.done) : Icon(Icons.map);
}
