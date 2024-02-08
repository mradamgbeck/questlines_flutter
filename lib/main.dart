import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questlines/pages/active_quest_page.dart';
import 'package:questlines/pages/completed_quest_page.dart';
import 'package:questlines/pages/debug_panel.dart';
import 'package:questlines/pages/edit_quest_page.dart';
import 'package:questlines/pages/selected_quest_page.dart';
import 'package:questlines/state/app_state.dart';
import 'package:questlines/state/database.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Database db = Database();
  runApp(MyApp(
    db: db,
  ));
}

class MyApp extends StatelessWidget {
  final Database db;
  const MyApp({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MyAppState(),
        child: MaterialApp(
          title: 'Questlines',
          theme: ThemeData(
              useMaterial3: true, colorScheme: const ColorScheme.dark()),
          home: MainPage(title: 'QUESTLINES', db: db),
        ));
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title, required this.db});
  final String title;
  final Database db;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedPage) {
      case 0:
        page = SelectedQuestPage(widget.db);
      case 1:
        page = ActiveQuestPage(widget.db);
      case 2:
        page = CompletedQuestPage(widget.db);
      case 3:
        page = EditQuestPage(widget.db);
      case 4:
        page = DebugPanel(widget.db);
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
                label: 'Debug',
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
