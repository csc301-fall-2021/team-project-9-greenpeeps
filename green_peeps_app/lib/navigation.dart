import 'package:flutter/material.dart';
import 'package:green_peeps_app/home_screen.dart';
import 'package:green_peeps_app/goals_screen.dart';
import 'package:green_peeps_app/resources_screen.dart';
import 'package:green_peeps_app/profile_screen.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

BottomNavigationBarItem _navButton(String buttonText) {
  return BottomNavigationBarItem(
    icon: ImageIcon(
      AssetImage('images/' + buttonText + '.png'),
      size: 40.0,
    ),
    label: buttonText,
  );
}

class _NavigationState extends State<Navigation> {
  // This is the starting index of the navigation bar items
  // looking from left to right
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const GoalsScreen(),
    const ResourcesScreen(),
    const ProfileScreen()
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(157, 207, 148, 1),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // elevation: for adding shadow
        backgroundColor: const Color.fromRGBO(201, 221, 148, 1),
        selectedItemColor: Colors.teal.shade900,
        unselectedItemColor: Colors.green.shade700,
        selectedLabelStyle: const TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
          fontFamily: "Nunito",
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
        ),
        items: <BottomNavigationBarItem>[
          _navButton('Home'),
          _navButton('Goals'),
          _navButton('Resources'),
          _navButton('Profile')
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
