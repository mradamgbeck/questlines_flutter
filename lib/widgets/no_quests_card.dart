import 'package:flutter/material.dart';

class NoQuestsCard extends StatelessWidget {
  const NoQuestsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Card(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('No Quests, M\'Lord!', textAlign: TextAlign.center),
          )),
        ],
      ),
    );
  }
}
