import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questlines/state/app_state.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var selectedQuest = appState.getSelectedQuest();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          selectedQuest != null
              ? Column(
                  children: [
                    Text('Current Quest: ${selectedQuest.name}'),
                    Text(
                        'Current Stage: ${selectedQuest.getSelectedStage().name}')
                  ],
                )
              : const Text('No Quest Selected')
        ],
      ),
    );
  }
}
