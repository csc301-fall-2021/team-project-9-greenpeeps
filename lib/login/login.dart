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
  String error = '';
  final boxColour = const Color.fromRGBO(248, 244, 219, 1);
  final backgroundColour = const Color.fromRGBO(157, 207, 148, 1);
  final buttonColour = const Color.fromRGBO(91, 180, 89, 1);

  // Define an async function to create a new user with the fetched email and password
  void signInEmailPassword(email, password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => Navigator.pushNamed(context, '/nav'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() => error = 'Account not found.');
      } else if (e.code == 'wrong-password') {
        setState(() => error = 'Incorrect password.');
      } else {
        setState(() => error = e.code);
      }
    }
  }

  String checkFields(email, password) {
    if (password.isEmpty || email.isEmpty) {
      return 'All fields must be filled.';
    }
    return 'valid';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColour,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Center(
            heightFactor: 1.3,
            child: Form(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding: const EdgeInsets.all(75.0),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/greenpeepswiz.png'),
                          ),
                          shape: BoxShape.circle),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 1.0),
                  Material(
                    color: boxColour,
                    borderRadius: BorderRadius.circular(5),
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: TextFormField(
                        onChanged: (val) {
                          setState(() => {email = val});
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Password",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 1.0),
                  Material(
                    color: boxColour,
                    borderRadius: BorderRadius.circular(5),
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: TextFormField(
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => {password = val});
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      minimumSize: const Size(double.infinity, 50),
                      primary: buttonColour,
                    ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () async {
                      var checkStatus = checkFields(email, password);
                      if (checkStatus == 'valid') {
                        signInEmailPassword(email.trim(), password.trim());
                      } else {
                        setState(() => error = checkStatus);
                      }
                    },
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
