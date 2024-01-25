// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questlines/state/app_state.dart';
import 'package:questlines/widgets/quest_card.dart';

import '../types/quest.dart';
import '../types/stage.dart';

class NewQuestPage extends StatefulWidget {
  const NewQuestPage({super.key});

  @override
  State<NewQuestPage> createState() => _NewQuestPageState();
}

class _NewQuestPageState extends State<NewQuestPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController questController = TextEditingController();

  TextEditingController stageController = TextEditingController();
  var stages = <Stage>[];

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var quest = Quest(questController.text, stages);

    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: questController,
                decoration: InputDecoration(label: Text('Quest Name')),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  quest.name = questController.text;
                  // questController.clear();
                });
              },
              child: const Text('Set Quest Name'),
            ),
            SizedBox(
              height: 25,
            ),
            Text('Stages'),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: stageController,
                decoration: InputDecoration(label: Text('Stage Name')),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  stages.add(Stage(stageController.text));
                  stageController.clear();
                });
              },
              child: const Text('Add Stage'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  quest.stages = stages;
                  appState.addQuest(quest);
                  questController.clear();
                  stageController.clear();
                  stages = <Stage>[];
                  quest = Quest(questController.text, stages);
                });
              },
              child: const Text('Save Quest'),
            ),
            QuestCard(quest, true, true)
          ],
        ));
  }
}
