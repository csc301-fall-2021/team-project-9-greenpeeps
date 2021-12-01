import 'package:flutter/material.dart';

// Import the different app routes (ex. go to login page, home page, etc.)
import 'package:green_peeps_app/navigation.dart';
import 'package:green_peeps_app/welcome.dart';
import 'package:green_peeps_app/loading.dart';
import 'package:green_peeps_app/login/login.dart';
import 'package:green_peeps_app/new_user_questionnaire/initial_questionnaire.dart';
import 'package:green_peeps_app/login/new_account.dart';
import 'package:green_peeps_app/homescreen/learn_more.dart';
import 'package:green_peeps_app/login/accounthome.dart';
import 'package:green_peeps_app/new_user_questionnaire/initial_questionnaire_intro.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:green_peeps_app/welcome_info.dart';



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
      theme: ThemeData(
        fontFamily: "Nunito",
        scrollbarTheme: ScrollbarThemeData(
          isAlwaysShown: true,
          thickness: MaterialStateProperty.all(10),
          thumbColor: MaterialStateProperty.all(Colors.grey),
          radius: const Radius.circular(10),
        ),
      ),
      initialRoute: '/accounthome',
      onGenerateRoute: (settings) {
        if (settings.name == '/init_questionnaire') {
          final value = settings.arguments as List<String>?;
          return MaterialPageRoute(
              builder: (_) => InitialQuestionnaire(remainingQuestions: value));
        }
      },
      routes: {
        // '/': (context) => Loading(),
        '/welcome': (context) => Welcome(),
        '/nav': (context) => Navigation(),
        '/accounthome': (context) => AccountHome(),
        '/login': (context) => Login(),
        '/new': (context) => NewAccount(),
        '/learn_more': (context) => LearnMore(),
        '/init_questionnaire_intro': (context) => InitialQuestionnaireIntro(),
        '/welcome_info': (context) => WelcomeInfo(),
      },
    );
  }
}
