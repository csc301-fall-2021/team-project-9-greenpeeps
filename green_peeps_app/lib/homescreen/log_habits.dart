import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogHabits extends StatefulWidget {
  final VoidCallback saveHabits;
  const LogHabits({Key? key, required this.saveHabits}) : super(key: key);

  @override
  _LogHabitsState createState() => _LogHabitsState();
}

class _LogHabitsState extends State<LogHabits> {
  // Map of which checkboxes are checked
  Map<int, bool> _habitMap = {};
  List habitKeys = [];
  List habitList = [];

  @override
  void initState() {
    super.initState();
    getHabitKeys().then((result) {
      setState(() {
        habitKeys = result;
        for (var key in habitKeys) {
          getHabitTitles(key).then((r) {
            setState(() {
              habitList.add(r);
            });
          });
        }
      });
    });
  }

  getHabitKeys() async {
    var userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (userSnapshot.exists) {
      habitKeys = userSnapshot['habitInfo'].keys.toList();
      return habitKeys;
    } else {
      return null;
    }
  }

  getHabitTitles(key) async {
    var habitSnapshot =
        await FirebaseFirestore.instance.collection('habits').doc(key).get();
    if (habitSnapshot.exists) {
      return habitSnapshot['title'];
    } else {
      return null;
    }
  }

  Widget _makeHabitCheckbox(setState, String habitName, int habitID) {
    if (_habitMap[habitID] == null) {
      _habitMap[habitID] = false;
    }
    return CheckboxListTile(
      title: Text(habitName),
      activeColor: const Color.fromRGBO(0, 154, 6, 1),
      controlAffinity: ListTileControlAffinity.leading,
      value: _habitMap[habitID],
      onChanged: (bool? value) {
        setState(
          () {
            _habitMap[habitID] = value!;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "What habits have you completed today?",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 415,
          child: SingleChildScrollView(
            child: Column(children: [
              for (var i = 0; i < habitList.length; i++)
                _makeHabitCheckbox(setState, habitList[i], i),
            ]),
          ),
        ),
        Row(
          children: <Widget>[
            const Spacer(),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                widget.saveHabits();
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: const Color.fromRGBO(2, 152, 89, 1),
                elevation: 5,
                fixedSize: const Size(61, 25),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
