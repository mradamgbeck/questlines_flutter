import 'dart:math';
import 'package:questlines/constants.dart';
import 'package:questlines/types/quest.dart';
import 'package:questlines/types/stage.dart';
import 'package:string_extension/string_extension.dart';
import 'package:word_generator/word_generator.dart';

var wordGen = WordGenerator();

generateQuest() {
  var quest = Quest()..name = getRandomVerbTheNoun();
  var stageAmount = Random().nextInt(8) + 1;
  List<Stage> stages = [];
  for (var i = 0; i < stageAmount; i++) {
    Stage stage = Stage()
      ..name = getRandomVerbTheNoun()
      ..quest.value = quest
      ..priority = i
      ..latitude = getRandomLatitude()
      ..longitude = getRandomLongitude();

    if (Random().nextBool()) {
      var maxDate = INT_MAX;
      var millis = maxDate - 100 * Random().nextInt(4294967296);
      stage.deadline = DateTime.fromMillisecondsSinceEpoch(millis);
    }

    stages.add(stage);
  }
  stages[0].selected = true;
  quest.stages.addAll(stages);
  return quest;
}

getRandomLatitude() {
  var random = Random();
  double min = 42.18725;
  double max = 42.27741;
  return min + random.nextDouble() * (max-min) ;
}

getRandomLongitude() {
  var random = Random();
  double min = -83.79626;
  double max = -83.51207;
  return min + random.nextDouble() * (max-min) ;
}

getRandomVerbTheNoun() =>
    '${wordGen.randomVerb().capitalize()} the ${wordGen.randomNoun()}';

getRandomSentence() {
  return 'Not a quest in sight, ${wordGen.randomVerb()}ing the ${wordGen.randomSentence()}, M\'Lord!';
}
