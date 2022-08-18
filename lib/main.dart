import 'package:flutter/material.dart';
import 'package:jadwalku/providers/selected_timeline_provider.dart';
import 'package:provider/provider.dart';

import '../screens/main_menu_screen.dart';
import '../providers/timeline_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: ((context) {
        return TimelineProvider();
      })),
      ChangeNotifierProvider(create: ((context) {
        return SelectedTimelineProvider();
      }))
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
      title: "Jadwalku",
      home: const MainMenuScreen(),
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        // primaryColor: const Color(0xFFB83B5E),
        primaryColor: Colors.amber,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.dark,
    );
  }
}
