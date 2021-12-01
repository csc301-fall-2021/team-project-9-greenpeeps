import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountHome extends StatefulWidget {
  const AccountHome({Key? key}) : super(key: key);

  @override
  _AccountHomeState createState() => _AccountHomeState();
}

class _AccountHomeState extends State<AccountHome> {
  final boxColour = const Color.fromRGBO(248, 244, 219, 1);
  final backgroundColour = const Color.fromRGBO(157, 207, 148, 1);
  final buttonColour = const Color.fromRGBO(91, 180, 89, 1);
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColour,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Center(
            heightFactor: 1.2,
            child: Form(
              child: Column(
                children: <Widget>[
                  const Text(
                    "Green Peeps",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding: const EdgeInsets.all(135.0),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/greenpeepswiz.png'),
                          ),
                          shape: BoxShape.circle),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      minimumSize: const Size(double.infinity, 50),
                      primary: Colors.deepOrange[400],
                    ),
                    icon: const FaIcon(FontAwesomeIcons.google),
                    label: const Text(
                      'Continue with Google',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () async {},
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      minimumSize: const Size(double.infinity, 50),
                      primary: Colors.blue[400],
                    ),
                    icon: const FaIcon(FontAwesomeIcons.facebook),
                    label: const Text(
                      'Continue with Facebook',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () async {},
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      minimumSize: const Size(double.infinity, 50),
                      primary: boxColour,
                    ),
                    child: const Text(
                      'Sign in with email',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          minimumSize: const Size(1, 50),
                          primary: boxColour,
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () async {
                          Navigator.pushNamed(context, '/new');
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          minimumSize: const Size(1, 50),
                          primary: boxColour,
                        ),
                        child: const Text(
                          'Guest',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () async {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: 'guest@greenpeeps.com',
                                  password: 'guestapp')
                              .then((value) =>
                                  Navigator.pushNamed(context, '/nav'));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    error,
                    style: TextStyle(
                      color: Colors.red[700],
                      fontSize: 18.0,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
