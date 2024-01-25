import 'dart:math';
import 'package:questlines/types/quest.dart';
import 'package:string_extension/string_extension.dart';
import 'package:word_generator/word_generator.dart';

import '../types/stage.dart';

var wordGen = WordGenerator();

generateQuest() {
  var quest = Quest(getRandomVerbTheNoun(), [Stage(getRandomVerbTheNoun())]);
  var rando = Random().nextInt(8) + 1;
  for (var i = 0; i < rando; i++) {
    quest.addStage(getRandomVerbTheNoun());
  }
  return quest;
}

getRandomVerbTheNoun() =>
    '${wordGen.randomVerb().capitalize()} the ${wordGen.randomNoun()}';

getRandomSentence() {
  return 'Not a quest in sight, ${wordGen.randomVerb()}ing the ${wordGen.randomSentence()}, M\'Lord!';
}
