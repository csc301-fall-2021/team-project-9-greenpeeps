import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountHome extends StatefulWidget {
  const AccountHome({Key? key}) : super(key: key);

  @override
  _AccountHomeState createState() => _AccountHomeState();
}

class _AccountHomeState extends State<AccountHome> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var boxColour = Color.fromRGBO(248, 244, 219, 1);
  var backgroundColour = Color.fromRGBO(157, 207, 148, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColour,
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange[400],
                      ),
                      child: Text('Continue with Google',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () async {},
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue[400],
                      ),
                      child: Text('Continue with Facebook',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () async {},
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: boxColour,
                      ),
                      child: Text('Sign in with email',
                          style: TextStyle(color: Colors.black)),
                      onPressed: () async {
                        Navigator.pushNamed(context, '/login');
                      },
                    ),
                    Row(children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        child: Text('Register',
                            style: TextStyle(color: Colors.black)),
                        onPressed: () async {
                          Navigator.pushNamed(context, '/new');
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        child: Text('Guest',
                            style: TextStyle(color: Colors.black)),
                        onPressed: () async {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: 'guest@greenpeeps.com',
                                  password: 'guestapp')
                              .then((value) =>
                                  Navigator.pushNamed(context, '/nav'));
                          // await FirebaseAuth.instance.signInAnonymously().then(
                          //     (value) => Navigator.pushNamed(context, '/nav'));
                        },
                      )
                    ])
                  ],
                ))));
  }
}
