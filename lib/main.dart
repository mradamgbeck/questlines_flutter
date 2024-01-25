import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questlines/pages/debug_panel.dart';
import 'package:questlines/pages/quest_list_page.dart';
import 'package:questlines/pages/selected_quest_page.dart';
import 'package:questlines/state/app_state.dart';

import 'pages/edit_quest_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MyAppState(),
        child: MaterialApp(
          title: 'Questlines',
          theme: ThemeData(
              useMaterial3: true, colorScheme: const ColorScheme.dark()),
          home: const MainPage(title: 'Questlines'),
        ));
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    Widget page;
    switch (selectedPage) {
      case 0:
        page = const SelectedQuestPage();
      case 1:
        page = QuestListPage(appState.activeQuests);
      case 2:
        page = QuestListPage(appState.completedQuests);
      case 3:
        page = EditQuestPage();
     case 4:
        page = const DebugPanel();
      default:
        throw UnimplementedError('No widget for $selectedPage');
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Column(children: [
          SafeArea(
              child: NavigationBar(
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.bungalow),
                label: 'Selected',
              ),
              NavigationDestination(
                icon: Icon(Icons.book),
                label: 'Active',
              ),
              NavigationDestination(
                icon: Icon(Icons.done),
                label: 'Complete',
              ),
              NavigationDestination(
                icon: Icon(Icons.add),
                label: 'New',
              ),
              NavigationDestination(
                icon: Icon(Icons.bug_report),
                label: 'Debug Panel',
              ),
            ],
            selectedIndex: selectedPage,
            onDestinationSelected: (value) => {
              setState(() {
                selectedPage = value;
              })
            },
          )),
          Expanded(
              child: Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: page,
          )),
        ]));
  }
}
