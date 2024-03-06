// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:questlines/constants/icons.dart';
import 'package:questlines/pages/edit_quest_page.dart';
import 'package:questlines/services/time.dart';
import 'package:questlines/types/stage.dart';
import 'package:questlines/widgets/styled_text.dart';
import '../types/quest.dart';

class QuestCard extends StatelessWidget {
  final Quest quest;
  final bool isListPage;
  final bool displayOnly;
  final db;

  late Stage selectedStage;
  List<Stage> sortedStages = [];
  QuestCard(this.db, this.quest, this.isListPage, this.displayOnly,
      {super.key}) {
    if (!quest.complete) {
      selectedStage = quest.getCurrentStage();
    }
    sortedStages = quest.getStagesSorted();
  }

  @override
  Widget build(BuildContext context) {
    getIcon(thing) => thing.complete
        ? COMPLETED_ICON
        : thing.selected
            ? SELECTED_ICON
            : UNSELECTED_ICON;

    getStagesWidgets() => Column(
          children: [
            if (isListPage)
              for (var stage in sortedStages)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getIcon(stage),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: SizedBox(
                          width: 190,
                          child: Column(
                            children: [
                              StyledText.cardBody(stage.name),
                              StyledText.cardBody(
                              "${stage.getCompletedLocationFraction()}")
                            ],
                          ),
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
                    child: SizedBox(
                      width: 190,
                      child: Column(
                        children: [
                          StyledText.cardBody(selectedStage.name),
                          StyledText.cardBody(
                              "${selectedStage.getCompletedLocationFraction()}"),
                          if (selectedStage.deadline != null)
                            StyledText.cardBody(
                                '${getRemainingTime(selectedStage.deadline)} remain')
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () => {db.completeStage(selectedStage)},
                      child: StyledText.navButton("done"))
                ],
              )
          ],
        );

    List<Widget> getOptionButtons() {
      return !displayOnly
          ? <Widget>[
              IconButton(
                icon: Icon(quest.selected ? Icons.nightlight : Icons.explore),
                onPressed: () => {db.toggleSelectQuest(quest)},
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          EditQuestPage.withQuest(db, quest)));
                },
              ),
              IconButton(
                onPressed: () {
                  db.deleteQuest(quest);
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
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              leading: getIcon(quest),
              title: StyledText.cardTitle(quest.name),
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
