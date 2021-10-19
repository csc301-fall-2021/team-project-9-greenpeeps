import 'package:flutter/material.dart';
import 'package:green_peeps_app/homeScreen.dart';
import 'package:green_peeps_app/goalsScreen.dart';
import 'package:green_peeps_app/resourcesScreen.dart';
import 'package:green_peeps_app/profileScreen.dart';

class navigation extends StatefulWidget {
  const navigation({Key? key}) : super(key: key);

  @override
  _navigationState createState() => _navigationState();
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

class _navigationState extends State<navigation> {
  // This is the starting index of the navigation bar items
  // looking from left to right
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    homeScreen(),
    goalsScreen(),
    resourcesScreen(),
    profileScreen()
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(157, 207, 148, 1),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // elevation: for adding shadow
        backgroundColor: Color.fromRGBO(201, 221, 148, 1),
        selectedItemColor: Colors.teal.shade900,
        unselectedItemColor: Colors.green.shade700,
        selectedLabelStyle: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
          fontFamily: "Nunito",
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
          fontFamily: "Nunito",
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
