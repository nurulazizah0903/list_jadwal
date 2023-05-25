import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/task_model.dart';
import '../services/hive_service.dart';
import '../models/timeline_model.dart';
import '../screens/main_menu_screen.dart';
import '../providers/timeline_provider.dart';
import '../providers/selected_timeline_provider.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(TimelineModelAdapter());

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: ((context) {
          return TimelineProvider();
        }),
      ),
      ChangeNotifierProvider(
        create: ((context) {
          return SelectedTimelineProvider();
        }),
      ),
      ChangeNotifierProvider(
        create: (context) => HiveService(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "List My Schedule",
      home: const MainMenuScreen(),
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color.fromARGB(255, 239, 7, 3),
        // primaryColor: Colors.amber,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.dark,
    );
  }
}
