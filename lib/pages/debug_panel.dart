import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questlines/services/generator.dart';
import 'package:questlines/state/app_state.dart';
import 'package:word_generator/word_generator.dart';

class DebugPanel extends StatelessWidget {
  const DebugPanel({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    addQuest() {
      appState.activeQuests.add(generateQuest());
    }

    clearQuests() {
      appState.activeQuests = [];
      appState.completedQuests = [];
    }

    return ListView(
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
