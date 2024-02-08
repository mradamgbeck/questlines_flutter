// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:questlines/services/sizes.dart';
import 'package:questlines/services/time.dart';
import 'package:questlines/types/quest.dart';
import '../types/stage.dart';

class EditQuestPage extends StatefulWidget {
  Quest quest = Quest();

  var editing = false;

  var db;

  EditQuestPage(this.db, {super.key, this.editing = false});
  EditQuestPage.withQuest(this.db, this.quest,
      {super.key, this.editing = true});
  @override
  State<EditQuestPage> createState() => _EditQuestPageState();
}

class _EditQuestPageState extends State<EditQuestPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController questController = TextEditingController();
  TextEditingController stageController = TextEditingController();
  List<Stage> stages = [];
  @override
  Widget build(BuildContext context) {
    questController.text = widget.quest.name;
    if(widget.quest.stages.isNotEmpty){
      stages = widget.quest.stages.toList();
    }
    DateTime? stageDeadline;

    selectFirstStage() {
      for (int i = 0; i < stages.length; i++) {
        i == 0 ? stages[i].selected = true : stages[i].selected = false;
      }
    }

    getPrioritiesInOrder() {
      for (int i = 0; i < stages.length; i++) {
        stages[i].priority = i;
      }
    }

    moveStageUp(stageToMoveUp) {
      int oldIndex = stages.indexOf(stageToMoveUp);
      if (oldIndex > 0) {
        stages.remove(stageToMoveUp);
        stages.insert(oldIndex - 1, stageToMoveUp);
      }
      selectFirstStage();
      getPrioritiesInOrder();
    }

    moveStageDown(stageToMoveDown) {
      int oldIndex = stages.indexOf(stageToMoveDown);
      if (oldIndex < stages.length - 1) {
        stages.remove(stageToMoveDown);
        stages.insert(oldIndex + 1, stageToMoveDown);
      }
      selectFirstStage();
      getPrioritiesInOrder();
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
                      width: getPercentageOfScreen(context, 0.75),
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
                      width: getPercentageOfScreen(context, 0.75),
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
                              Stage stage = Stage()
                                ..name = (stageController.text)
                                ..quest.value = widget.quest;
                              if (stageDeadline != null) {
                                stage.deadline = stageDeadline;
                              }
                              stages.add(stage);
                              selectFirstStage();
                              getPrioritiesInOrder();
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
                              for (var stage in stages)
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
                                              setState(
                                                  () => stages.remove(stage)),
                                            }),
                                    Flexible(
                                      child: ListTile(
                                        key: ValueKey(stage.id),
                                        title: Column(
                                          children: [
                                            Text(stage.name),
                                            if (stage.deadline != null)
                                              Text(formatDateTime(
                                                  stage.deadline)),
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
                    setState(() {
                      widget.quest.stages.addAll(stages);
                      stages = [];
                      questController.clear();
                      widget.db.saveQuest(widget.quest);
                    });
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
