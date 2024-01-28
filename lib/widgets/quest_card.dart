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

    getQuestTile() {
      Stage selectedStage = quest.stages[quest.currentStage];
      return isListPage
          ? ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              leading: getQuestIcon(),
              title: Text(quest.name),
            )
          : ListTile(
              titleAlignment: ListTileTitleAlignment.center,
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
              IconButton(
                icon: Icon(quest.selected ? Icons.nightlight : Icons.explore),
                onPressed: () => {appState.toggleSelectQuest(quest)},
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditQuestPage.withQuest(quest)));
                },
              ),
              IconButton(
                onPressed: () {
                  appState.deleteActiveQuest(quest);
                },
                icon: Icon(Icons.delete),
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
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: getOptionButtons(),
          ),
        ],
      ),
    );
  }

  Icon getQuestIcon() => quest.complete
      ? Icon(Icons.done)
      : quest.selected
          ? Icon(Icons.explore)
          : Icon(Icons.nightlight);
}
