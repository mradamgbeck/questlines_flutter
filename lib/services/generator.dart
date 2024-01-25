import 'dart:math';
import 'package:questlines/types/quest.dart';
import 'package:string_extension/string_extension.dart';
import 'package:word_generator/word_generator.dart';

import '../types/stage.dart';

var wordGen = WordGenerator();

generateQuest() {
  var quest = Quest(generateBullshit(), [Stage(generateBullshit())]);
  var rando = Random().nextInt(8) + 1;
  for (var i = 0; i < rando; i++) {
    quest.addStage(generateBullshit());
  }
  return quest;
}

generateBullshit() =>
    '${wordGen.randomVerb().capitalize()} the ${wordGen.randomNoun()}';
