// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questlines/state/app_state.dart';
import '../types/quest.dart';
import '../types/stage.dart';

class EditQuestPage extends StatefulWidget {
  Quest quest;

  EditQuestPage(this.quest, {super.key});

  @override
  State<EditQuestPage> createState() => _EditQuestPageState();
}

class _EditQuestPageState extends State<EditQuestPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController questController = TextEditingController();

  TextEditingController stageController = TextEditingController();
  var stages = <Stage>[];

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    questController.text = widget.quest.name;

    moveStageUp(stage) {
      int index = widget.quest.stages.indexOf(stage);
      if (index > 0) {
        var temp = widget.quest.stages[index];
        widget.quest.stages.remove(stage);
        widget.quest.stages.insert(index - 1, temp);
      }
    }

    moveStageDown(stage) {
      int index = widget.quest.stages.indexOf(stage);
      if (index < widget.quest.stages.length - 1) {
        var temp = widget.quest.stages[index + 1];
        widget.quest.stages.removeAt(index + 1);
        widget.quest.stages.insert(index, temp);
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250,
                  child: TextFormField(
                    controller: questController,
                    decoration: InputDecoration(label: Text('Quest Name')),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.quest.name = questController.text;
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
                      widget.quest.stages.add(Stage(stageController.text));
                      stageController.clear();
                    });
                  },
                  child: const Text('Add Stage'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      appState.addQuest(widget.quest);
                      questController.clear();
                      stageController.clear();
                      stages = <Stage>[];
                    });
                  },
                  child: const Text('Save Quest'),
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ListTile(
                    leading: Icon(Icons.map),
                    title: Text(widget.quest.name),
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      for (var stage in widget.quest.stages)
                        Row(
                          children: [
                            IconButton.filled(
                                icon: Icon(Icons.arrow_upward),
                                onPressed: () {
                                  {
                                    setState(() => moveStageUp(stage));
                                  }
                                }),
                            IconButton.filled(
                                icon: Icon(Icons.arrow_downward),
                                onPressed: () {
                                  {
                                    setState(() => moveStageDown(stage));
                                  }
                                }),
                            IconButton.filled(
                                icon: Icon(Icons.delete),
                                onPressed: () => {
                                      setState(() =>
                                          widget.quest.stages.remove(stage)),
                                    }),
                            Flexible(
                              child: ListTile(
                                key: ValueKey(stage.id),
                                title: Text(stage.name),
                              ),
                            ),
                          ],
                        )
                    ],
                  )
                ])
              ],
            )),
      ),
    );
  }
}
