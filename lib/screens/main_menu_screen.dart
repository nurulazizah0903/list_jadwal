import 'package:flutter/material.dart';

import '../screens/timeline_screen.dart';
import '../screens/unplaned_screen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  int _selectedNavbar = 0;

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  final List<Widget> _screens = const [
    TimelineScreen(),
    UnplanedScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _screens[_selectedNavbar],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: "Timeline",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark_rounded),
            label: "Unplaned",
          ),
        ],
        currentIndex: _selectedNavbar,
        selectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        showUnselectedLabels: true,
        onTap: _changeSelectedNavBar,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}