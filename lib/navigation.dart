import 'package:flutter/material.dart';

// Import the different navigation bar screens
import 'package:green_peeps_app/homescreen/home_screen.dart';
import 'package:green_peeps_app/habits/habits_screen.dart';
import 'package:green_peeps_app/articles/articles_screen.dart';
import 'package:green_peeps_app/profile/profile_screen.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  // Index of current navigation bar button counting from left to right
  int _currIndex = 0;

  // The different screen options for the center of the scaffold
  final List<Widget> _screenOptions = <Widget>[
    const HomeScreen(),
    const HabitsScreen(),
    const ArticlesScreen(),
    const ProfileScreen()
  ];

  // Updates which screen option is currently in the center of the scaffold
  void _onButtonTap(int index) {
    setState(() {
      _currIndex = index;
    });
  }

  // Customizes the appearance of bottom navigation bar buttons
  BottomNavigationBarItem _navButton(String buttonText) {
    return BottomNavigationBarItem(
      label: buttonText,
      icon: ImageIcon(
        AssetImage('images/' + buttonText + '.png'),
        size: 40.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(157, 207, 148, 1),
      body: Center(
        child: _screenOptions.elementAt(_currIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
          _navButton('Habits'),
          _navButton('Articles'),
          _navButton('Profile')
        ],
        currentIndex: _currIndex,
        onTap: _onButtonTap,
      ),
    );
  }
}
