import 'package:flutter/material.dart';
import 'package:questlines/services/generator.dart';
import 'package:word_generator/word_generator.dart';

class DebugPanel extends StatelessWidget {
  final db;

  const DebugPanel(this.db, {super.key});

  @override
  Widget build(BuildContext context) {
    addQuest() {
      db.saveQuest(generateQuest());
    }

    clearQuests() {
      db.clearQuests();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(onPressed: addQuest, child: const Text('Add Quest')),
        ElevatedButton(
            onPressed: clearQuests, child: const Text('Clear Quests')),
      ],
    );
  }

  String generateBullshit(WordGenerator wordGen) =>
      '${wordGen.randomVerb()} the ${wordGen.randomNoun()}';
}
