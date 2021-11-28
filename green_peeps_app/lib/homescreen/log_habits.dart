import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_peeps_app/services/habit_firestore.dart';

class LogHabits extends StatefulWidget {
  final VoidCallback saveHabits;
  const LogHabits({Key? key, required this.saveHabits}) : super(key: key);

  @override
  _LogHabitsState createState() => _LogHabitsState();
}

class _LogHabitsState extends State<LogHabits> {
  final ScrollController _controller = ScrollController();

  // Map of which checkboxes are checked
  Map<String, bool> _habitMap = {};
  List dailyHabitKeys = [];
  List dailyHabitList = [];

  @override
  void initState() {
    super.initState();
    getHabitKeys().then(
      (result) {
        setState(
          () {
            dailyHabitKeys = result;
            for (var key in dailyHabitKeys) {
              getHabitFromStore(key).then(
                (r) {
                  setState(
                    () {
                      dailyHabitList.add(r);
                    },
                  );
                },
              );
            }
          },
        );
      },
    );
  }

  // Fetch Habit IDs from user's habit list
  getHabitKeys() async {
    var userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (userSnapshot.exists) {
      var dailyHabitKeys = userSnapshot['userHabits'].keys.toList();
      var copyKeys = [...dailyHabitKeys];
      for (var key in copyKeys) {
        if (!userSnapshot['userHabits'][key]['isDailyHabit'] ||
            userSnapshot['userHabits'][key]['isDailyCompleted']) {
          dailyHabitKeys.remove(key);
        }
      }
      return dailyHabitKeys;
    } else {
      return null;
    }
  }

  logHabitToDB(key) async {
    var userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (userSnapshot.exists && userSnapshot['userHabits'] != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'userHabits.' + key + '.repsLeft': FieldValue.increment(-1),
        'userHabits.' + key + '.isDailyCompleted': true
      }).then((value) => {});
      // var reps = userSnapshot['userHabits'][key]['reps'];
      // if (reps == all)
    }
  }

  Widget _makeHabitCheckbox(setState, String habitName, String habitID) {
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
        const Divider(color: Colors.transparent),
        SizedBox(
          height: 275,
          child: Scrollbar(
            controller: _controller,
            child: SingleChildScrollView(
              controller: _controller,
              child: Column(
                children: [
                  for (var i = 0; i < dailyHabitList.length; i++)
                    _makeHabitCheckbox(setState, dailyHabitList[i].title,
                        dailyHabitList[i].id),
                ],
              ),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            const Spacer(),
            TextButton(
              child: const Text(
                'Save',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                if (dailyHabitList.isEmpty) {
                  Navigator.of(context).pop(); // Closes popup
                } else {
                  _habitMap.forEach((key, value) {
                    if (value) {
                      logHabitToDB(key).then((value) => {});
                    }
                  });
                  widget.saveHabits();
                }
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: const Color.fromRGBO(2, 152, 89, 1),
                elevation: 5,
                fixedSize: const Size(60, 30),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
