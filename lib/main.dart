import 'package:flutter/material.dart';

import '../screens/main_menu_screen.dart';

void main() {
  runApp(const MyApp());
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
        scaffoldBackgroundColor: const Color(0xFF222831),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF222831),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF393E46),
          selectedItemColor: Color(0xFFFFD369),
          unselectedItemColor: Color(0xFFEEEEEE),
        ),
        primaryColor: const Color.fromARGB(255, 253, 198, 69),
      ),
    );
  }
}
