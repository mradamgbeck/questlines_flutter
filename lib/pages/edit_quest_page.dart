// ignore_for_file: must_be_immutable

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questlines/state/app_state.dart';
import 'package:questlines/types/quest.dart';
import '../types/stage.dart';

class EditQuestPage extends StatefulWidget {
  Quest quest = Quest();

  var editing = false;

  EditQuestPage({super.key, this.editing = false});
  EditQuestPage.withQuest(this.quest, {super.key, this.editing = true});
  @override
  State<EditQuestPage> createState() => _EditQuestPageState();
}

class _EditQuestPageState extends State<EditQuestPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController questController = TextEditingController();
  TextEditingController stageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    questController.text = widget.quest.name;
    DateTime? stageDeadline;

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

    pickDeadlineDate() async {
      stageDeadline = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.fromMillisecondsSinceEpoch(8640000000000000));
    }

    pickDeadlineTime() async {
      var time =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      stageDeadline = DateTime(stageDeadline!.year, stageDeadline!.month,
          stageDeadline!.day, time!.hour, time.minute);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            widget.quest.name = value;
                          });
                        },
                        controller: questController,
                        decoration: InputDecoration(label: Text('Quest Name')),
                      ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            pickDeadlineDate();
                          },
                          child: const Icon(Icons.date_range),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            pickDeadlineTime();
                          },
                          child: const Icon(Icons.timer),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              Stage stage = Stage.forQuest(
                                  widget.quest.id, stageController.text);
                              if (stageDeadline != null) {
                                stage.deadline = stageDeadline;
                              }
                              widget.quest.stages.add(stage);
                              widget.quest.stages[widget.quest.currentStage]
                                  .selected = true;
                              stageController.clear();
                            });
                          },
                          child: const Text('Add Stage'),
                        ),
                      ],
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                                            setState(
                                                () => moveStageDown(stage));
                                          }
                                        }),
                                    IconButton.filled(
                                        icon: Icon(Icons.delete),
                                        onPressed: () => {
                                              setState(() => widget.quest.stages
                                                  .remove(stage)),
                                            }),
                                    Flexible(
                                      child: ListTile(
                                        key: ValueKey(stage.id),
                                        title: Column(
                                          children: [
                                            Text(stage.name),
                                            if (stage.deadline != null)
                                              Text(stage.getDeadline()),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ],
                          )
                        ])
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    appState.saveQuest(widget.quest);
                  },
                  child: const Text('Save Quest'),
                ),
                if (widget.editing)
                  ElevatedButton(
                    child: Text('Back to Quests'),
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
