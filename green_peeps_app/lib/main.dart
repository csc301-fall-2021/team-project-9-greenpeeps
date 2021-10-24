import 'package:flutter/material.dart';

// Import the different app routes (ex. go to login page, home page, etc.)
import 'package:green_peeps_app/navigation.dart';
import 'package:green_peeps_app/welcome.dart';
import 'package:green_peeps_app/loading.dart';
import 'package:green_peeps_app/login.dart';
import 'package:green_peeps_app/initial_questionnaire.dart';
import 'package:green_peeps_app/new_account.dart';
import 'package:green_peeps_app/learn_more.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      // return SomethingWentWrong();
      print("error in building the Firebase project");
    }

    return MaterialApp(
      theme: ThemeData(fontFamily: "Nunito"),
      initialRoute: '/welcome',
      routes: {
        '/': (context) => Loading(),
        '/welcome': (context) => Welcome(),
        '/nav': (context) => Navigation(),
        '/login': (context) => Login(),
        '/new': (context) => NewAccount(),
        '/learn_more': (context) => LearnMore()
      },
    );
  }
}
