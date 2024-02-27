// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:questlines/constants/icons.dart';
import 'package:questlines/constants/values.dart';
import 'package:questlines/services/sizes.dart';
import 'package:questlines/types/stage.dart';
import 'package:questlines/widgets/location_picker.dart';
import 'package:questlines/widgets/styled_text.dart';

class AddStage extends StatefulWidget {
  var stageCallback;

  AddStage(Null Function(Stage stage) callback, {super.key}) {
    stageCallback = callback;
  }

  @override
  State<AddStage> createState() => _AddStageState();
}

class _AddStageState extends State<AddStage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController stageController = TextEditingController();
  Stage stage = Stage();

  @override
  Widget build(BuildContext context) {
    pickDeadlineDate() async {
      stage.deadline = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.fromMillisecondsSinceEpoch(THE_END_OF_TIME));
    }

    pickDeadlineTime() async {
      var time =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      stage.deadline ??= DateTime.now();
      stage.deadline = DateTime(stage.deadline!.year, stage.deadline!.month,
          stage.deadline!.day, time!.hour, time.minute);
    }

    locationCallback(LatLng location) {
      setState(() {
        stage.latitude = location.latitude;
        stage.longitude = location.longitude;
      });
    }

    pickLocation() async {
      await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
                content: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                        height: getPercentageOfScreenHeight(context, 1),
                        width: getPercentageOfScreenWidth(context, 1),
                        child: LocationPicker(locationCallback)),
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

    return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              width: getPercentageOfScreenWidth(context, 0.75),
              child: TextFormField(
                controller: stageController,
                style: TextStyle(color: Colors.white),
                decoration:
                    InputDecoration(label: StyledText.cardTitle('Stage Name')),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    pickDeadlineDate();
                  },
                  child: SELECT_DATE_ICON,
                ),
                ElevatedButton(
                  onPressed: () {
                    pickDeadlineTime();
                  },
                  child: SELECT_TIME_ICON,
                ),
                ElevatedButton(
                  onPressed: () {
                    pickLocation();
                  },
                  child: SELECT_LOCATION_ICON,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                stage.name = stageController.text;
                widget.stageCallback(stage);
                Navigator.of(context).pop();
              },
              child: StyledText.navButton('Save'),
            ),
          ],
        ));
  }
}
