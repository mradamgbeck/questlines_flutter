// ignore_for_file: prefer_const_literals_to_create_immutables

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
    Stage selectedStage = quest.stages[quest.currentStage];

    Icon getIcon(thing) => thing.complete
        ? Icon(Icons.done)
        : thing.selected
            ? Icon(Icons.explore)
            : Icon(Icons.nightlight);

    Column getStagesWidgets() => Column(
          children: [
            if (isListPage)
              for (var stage in quest.stages)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getIcon(stage),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Column(
                          children: [
                            Text(stage.name),
                            if (stage.deadline != null)
                              Text('${stage.getRemainingTime()} remain')
                          ],
                        ),
                      )
                    ],
                  ),
                )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getIcon(selectedStage),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(selectedStage.name),
                        if (selectedStage.deadline != null)
                          Text('${selectedStage.getRemainingTime()} remain')
                      ],
                    ),
                  ),
                  TextButton(
                      onPressed: () => {appState.completeStage(selectedStage)},
                      child: Text("done"))
                ],
              )
          ],
        );

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

    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              leading: getIcon(quest),
              title: Text(quest.name),
            ),
            getStagesWidgets(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: getOptionButtons(),
            ),
          ],
        ),
      ),
    );
  }
}
