import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String email = '';
  String password = '';

  // Define an async function to create a new user with the fetched email and password
  void signInEmailPassword(email, password) async {
    try {
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => Navigator.pushNamed(context, '/nav'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
                child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Text("Email"),
                SizedBox(height: 1.0),
                TextFormField(
                  onChanged: (val) {
                    setState(() => {email = val});
                  },
                ),
                SizedBox(height: 20.0),
                Text("Password"),
                SizedBox(height: 1.0),
                TextFormField(
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => {password = val});
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink[400],
                  ),
                  child: Text('Sign in', style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    signInEmailPassword(email.trim(), password.trim());
                  },
                )
              ],
            ))));
  }
}
