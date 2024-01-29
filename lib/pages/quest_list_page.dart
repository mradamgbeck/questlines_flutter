// ignore_for_file: must_be_immutable, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:questlines/widgets/no_quests_card.dart';
import 'package:questlines/widgets/quest_card.dart';

class QuestListPage extends StatelessWidget {
  var quests;

  var isDisplayOnly;

  QuestListPage(this.quests, this.isDisplayOnly, {super.key});

  @override
  Widget build(BuildContext context) {
    Widget getQuestWidgets() {
      if (quests.isNotEmpty) {
        return ListView(
            children: quests
                .map<Widget>((quest) => QuestCard(quest, true, isDisplayOnly))
                .toList());
      }
      return NoQuestsCard();
    }

    return getQuestWidgets();
  }
}
