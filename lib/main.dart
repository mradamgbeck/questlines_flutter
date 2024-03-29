import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:questlines/constants/strings.dart';
import 'package:questlines/pages/active_quest_page.dart';
import 'package:questlines/pages/quest_history_page.dart';
import 'package:questlines/pages/debug_panel.dart';
import 'package:questlines/pages/edit_quest_page.dart';
import 'package:questlines/pages/quest_map_page.dart';
import 'package:questlines/state/app_state.dart';
import 'package:questlines/state/database.dart';
import 'package:questlines/widgets/styled_text.dart';

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
          title: APP_TITLE,
          theme: ThemeData(
              useMaterial3: true, 
              brightness: Brightness.dark,
              textTheme: GoogleFonts.cinzelDecorativeTextTheme()
              ),
          home: MainPage(title: APP_TITLE, db: db),
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
        page = QuestMapPage(widget.db);
      case 1:
        page = ActiveQuestPage(widget.db);
      case 2:
        page = QuestHistoryPage(widget.db);
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
          backgroundColor: Colors.black,
          title: StyledText.appTitle(widget.title),
        ),
        body: Column(children: [
          SafeArea(
              child: NavigationBar(
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.map),
                label: 'Map',
              ),
              NavigationDestination(
                icon: Icon(Icons.history_edu),
                label: 'Quests',
              ),
              NavigationDestination(
                icon: Icon(Icons.done),
                label: 'History',
              ),
              NavigationDestination(
                icon: Icon(Icons.add),
                label: 'New',
              ),
              // NavigationDestination(
              //   icon: Icon(Icons.bug_report),
              //   label: 'Debug',
              // ),
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
