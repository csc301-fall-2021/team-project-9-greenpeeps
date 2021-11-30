import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewAccount extends StatefulWidget {
  const NewAccount({Key? key}) : super(key: key);

  @override
  _NewAccountState createState() => _NewAccountState();
}

class _NewAccountState extends State<NewAccount> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';
  String error = '';
  final boxColour = const Color.fromRGBO(248, 244, 219, 1);
  final backgroundColour = const Color.fromRGBO(157, 207, 148, 1);
  final buttonColour = const Color.fromRGBO(91, 180, 89, 1);

  // Define an async function to create a new user with the fetched email and password
  Future<void> createUserEmailPassword(
      email, password, firstName, lastName) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                firestore
                    .collection('users')
                    .doc(value.user!.uid)
                    .set({
                      'email': email,
                      'firstName': firstName,
                      'lastName': lastName,
                      'achievements': [],
                      'carbonEmissions': {
                        'electricity': 0,
                        'food': 0,
                        'transportation': 0
                      },
                      'totalPoints': 0,
                      'userHabits': {}
                    })
                    .then((value) => Navigator.popAndPushNamed(
                        context, '/init_questionnaire'))
                    .catchError((error) => print("Failed to add user: $error"))
              });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        setState(() => error = 'Email already registered.');
      } else if (e.code == 'weak-password') {
        setState(() => error = 'The password provided is too weak.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColour,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Center(
            heightFactor: 1,
            child: Form(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding: const EdgeInsets.all(50.0),
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
                  const SizedBox(height: 20.0),
                  const Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "First Name",
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
                        onChanged: (val) {
                          setState(() => {firstName = val});
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Last Name",
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
                        onChanged: (val) {
                          setState(() => {lastName = val});
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
                      'Sign up',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () async {
                      createUserEmailPassword(email.trim(), password.trim(),
                          firstName.trim(), lastName.trim());
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
