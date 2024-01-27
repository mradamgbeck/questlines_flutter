import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:provider/provider.dart';
import 'package:questlines/pages/active_quests_page.dart';
import 'package:questlines/pages/debug_panel.dart';
import 'package:questlines/pages/completed_quests_page.dart';
import 'package:questlines/pages/edit_quest_page.dart';
import 'package:questlines/pages/selected_quest_page.dart';
import 'package:questlines/state/app_state.dart';
import 'package:questlines/state/object_box.dart';

late ObjectBox objectBox;
late Box questBox;
late Box stageBox;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
  questBox = objectBox.questBox;
  stageBox = objectBox.stageBox;
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
          home: const MainPage(title: 'QUESTLINES'),
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
    appState.setBoxes(questBox, stageBox);
    Widget page;
    switch (selectedPage) {
      case 0:
        page = SelectedQuestPage();
      case 1:
        page = ActiveQuestsPage();
      case 2:
        page = CompletedQuestsPage();
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
