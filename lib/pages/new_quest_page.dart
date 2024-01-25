// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questlines/state/app_state.dart';
import 'package:questlines/widgets/quest_card.dart';

import '../types/quest.dart';
import '../types/stage.dart';

class NewQuestPage extends StatelessWidget {
  NewQuestPage({super.key});
  final _formKey = GlobalKey<FormState>();

  TextEditingController questController = TextEditingController();
  TextEditingController stageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var stageName = '';
    var questName = '';
    var stages = [Stage(stageName)];
    var quest = Quest(questName, stages);

    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: questController,
                decoration: InputDecoration(label: Text('Quest Name')),
              ),
              TextFormField(
                controller: stageController,
                decoration: InputDecoration(label: Text('Stage Name')),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      quest.stages.add(Stage(stageController.text));
                    },
                    child: const Text('Add Stage'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      appState.addQuest(quest);
                    },
                    child: const Text('Save Quest'),
                  ),
                ],
              ),
              QuestCard(quest, true)
            ],
          )),
    );
  }
}
