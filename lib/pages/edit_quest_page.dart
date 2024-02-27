// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:questlines/constants/icons.dart';
import 'package:questlines/constants/strings.dart';
import 'package:questlines/constants/values.dart';
import 'package:questlines/main.dart';
import 'package:questlines/services/sizes.dart';
import 'package:questlines/services/time.dart';
import 'package:questlines/types/quest.dart';
import 'package:questlines/widgets/add_stage.dart';
import 'package:questlines/widgets/location_picker.dart';
import 'package:questlines/widgets/styled_text.dart';
import '../types/stage.dart';

class EditQuestPage extends StatefulWidget {
  Quest quest = Quest();
  LatLng? stageLocation;

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
    if (widget.quest.stages.isNotEmpty) {
      stages = widget.quest.getStagesSorted();
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

    void saveAll() {
      selectFirstStage();
      getPrioritiesInOrder();
      widget.db.saveStages(stages);
      widget.quest.stages.addAll(stages);
      widget.db.saveQuest(widget.quest);
    }

    addStage(stage) {
      stages.add(stage);
      widget.quest.stages.add(stage);
      saveAll();
      stageController.clear();
      widget.stageLocation = null;
      stageDeadline = null;
    }

    moveStageUp(stageToMoveUp) {
      int oldIndex = stages.indexOf(stageToMoveUp);
      if (oldIndex > 0) {
        stages.remove(stageToMoveUp);
        stages.insert(oldIndex - 1, stageToMoveUp);
      }
      saveAll();
    }

    moveStageDown(stageToMoveDown) {
      int oldIndex = stages.indexOf(stageToMoveDown);
      if (oldIndex < stages.length - 1) {
        stages.remove(stageToMoveDown);
        stages.insert(oldIndex + 1, stageToMoveDown);
      }
      saveAll();
    }

    removeStage(stage) {
      stages.remove(stage);
      widget.db.deleteStage(stage);
      widget.quest.stages.remove(stage);
      saveAll();
    }

    stageCallback(Stage stage) {
      setState(() {
        stage.quest.value = widget.quest;
        addStage(stage);
      });
    }

    createStage() async {
      await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
                content: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    SizedBox(
                        height: getPercentageOfScreenHeight(context, 0.25),
                        width: getPercentageOfScreenWidth(context, 1),
                        child: AddStage(stageCallback)),
                    Positioned(
                      right: -40,
                      top: -40,
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Icon(Icons.close),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
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
                      width: getPercentageOfScreenWidth(context, 0.75),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            widget.quest.name = value;
                          });
                        },
                        controller: questController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            label: StyledText.cardTitle('Quest Name')),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        createStage();
                      },
                      child: StyledText.navButton('Add Stage'),
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            leading: Icon(Icons.map),
                            title: StyledText.cardBody(widget.quest.name),
                          ),
                          Column(
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
                                                  () => removeStage(stage)),
                                            }),
                                    Flexible(
                                      child: ListTile(
                                        key: ValueKey(stage.id),
                                        title: Column(
                                          children: [
                                            StyledText.cardBody(stage.name),
                                            if (stage.deadline != null)
                                              StyledText.cardBody(
                                                  formatDateTime(
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
            ElevatedButton(
              child: StyledText.navButton('Save'),
              onPressed: () {
                saveAll();
                if (widget.editing) {
                  Navigator.maybePop(context);
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          MainPage(title: APP_TITLE, db: widget.db)));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
