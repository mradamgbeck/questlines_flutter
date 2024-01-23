import 'dart:math';
import 'package:questlines/types/quest.dart';
import 'package:string_extension/string_extension.dart';
import 'package:word_generator/word_generator.dart';

var wordGen = WordGenerator();

generateQuest() {
  var quest = Quest(generateBullshit());
  var rando = Random().nextInt(8) + 1;
  for (var i = 0; i < rando; i++) {
    quest.addStage(generateBullshit());
  }
  quest.stages[0].selected = true;
  return quest;
}

generateBullshit() => '${wordGen.randomVerb().capitalize()} the ${wordGen.randomNoun()}';
