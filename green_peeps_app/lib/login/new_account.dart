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

  // Define an async function to create a new user with the fetched email and password
  Future<void> createUserEmailPassword(
      email, password, firstName, lastName) async {
    try {
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                firestore
                    .collection('users')
                    .doc(value.user!.uid)
                    .set({
                      'email': email,
                      'firstName': firstName,
                      'lastName': lastName
                    })
                    .then((value) => Navigator.popAndPushNamed(
                            context, '/init_questionnaire', arguments: [
                          'F3Ct0WCqgIaAlkdrqE7X',
                          'rxxqFtUd9314aRYB8UiG'
                        ]))
                    .catchError((error) => print("Failed to add user: $error"))
              });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
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
              Text("First Name"),
              SizedBox(height: 1.0),
              TextFormField(
                onChanged: (val) {
                  setState(() => {firstName = val});
                },
              ),
              SizedBox(height: 20.0),
              Text("Last Name"),
              SizedBox(height: 1.0),
              TextFormField(
                onChanged: (val) {
                  setState(() => {lastName = val});
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink[400],
                ),
                child: Text('Sign up', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  createUserEmailPassword(email.trim(), password.trim(),
                      firstName.trim(), lastName.trim());
                },
              )
            ],
          ))),
    ));
  }
}
