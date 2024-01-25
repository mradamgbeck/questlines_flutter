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
        return quests
            .map<Widget>((quest) => QuestCard(quest, true, false))
            .toList();
      }
      return [
        SingleChildScrollView(
          child: Column(
            children: const [
              Card(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('No Quests, M\'Lord!', textAlign: TextAlign.center),
              )),
            ],
          ),
        )
      ];
    }

    return ListView(children: getQuestWidgets(quests));
  }
}
