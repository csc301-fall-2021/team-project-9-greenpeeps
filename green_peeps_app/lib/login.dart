import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';

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
                    print(email);
                    print(password);
                  },
                )
              ],
            ))));
  }
}
