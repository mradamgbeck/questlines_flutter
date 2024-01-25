import 'package:flutter/material.dart';
import 'package:questlines/types/quest.dart';
import 'package:questlines/widgets/quest_card.dart';

class QuestListPage extends StatelessWidget {
  const QuestListPage(this.quests, {super.key});
  final List<Quest> quests;
  @override
  Widget build(BuildContext context) {

    List<Widget> getQuestWidgets(quests) {
      if (quests.isNotEmpty) {
        return quests.map<Widget>((quest) => QuestCard(quest, true, false)).toList();
      }
      return [const Text('No Quests Available')];
    }

    return ListView(children: getQuestWidgets(quests));
  }
}
