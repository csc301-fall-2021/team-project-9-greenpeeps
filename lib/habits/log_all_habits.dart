import 'package:flutter/material.dart';
import 'package:green_peeps_app/habits/completed_log_habits_dialogue.dart';
import 'package:green_peeps_app/services/habit_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogAllHabits extends StatefulWidget {
  final Function(List, int) saveHabits;
  const LogAllHabits({Key? key,  required this.saveHabits}) : super(key: key);

  @override
  _LogAllHabitsState createState() => _LogAllHabitsState();
}

class _LogAllHabitsState extends State<LogAllHabits> {

  // Map of which checkboxes are checked
  Map<String, bool> _habitMap = {};
  Map<String, String> keyToTitleHabit = {};
  List allHabitKeys = [];
  List allHabitList = [];
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    getHabitKeys().then((result) {
      setState(() {
        allHabitKeys = result;
        for (var key in allHabitKeys) {
          getHabitFromStore(key).then((r) {
            setState(() {
              keyToTitleHabit[key] = r!.title;
              allHabitList.add(r);
            });
          });
        }
      });
    });
  }

  // Fetch Habit IDs from user's habit list
  getHabitKeys() async {
    var userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (userSnapshot.exists && userSnapshot['userHabits'] != null) {
      var habitKeys = userSnapshot['userHabits'].keys.toList();
      var copyKeys = [...habitKeys];
      for (var key in copyKeys) {
        if (userSnapshot['userHabits'][key]['completed'] || userSnapshot['userHabits'][key]['isDailyCompleted']) {
          habitKeys.remove(key);
        }
      }
      return habitKeys;
    } else {
      return [];
    }
  }

  logHabitToDB(Map<String, dynamic> habitMap) async {
    var userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (userSnapshot.exists && userSnapshot['userHabits'] != null) {
      List completedHabits = [];
      int count = 0;
      habitMap.forEach((key, value) async {
        if (value) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({
            'userHabits.' + key + '.repsLeft': FieldValue.increment(-1),
            'userHabits.' + key + '.isDailyCompleted': true
          }).then((value) => {});
          var repsLeft = userSnapshot['userHabits'][key]['repsLeft'];
          if (repsLeft == 1) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({'userHabits.' + key + '.completed': true}).then(
                    (value) => {});
            completedHabits.add(keyToTitleHabit[key]);
          }
          count++;
        }
      });
      return [completedHabits, count];
    }
  }

  Widget _makeHabitCheckbox(setState, String habitName, String habitID) {
    if (_habitMap[habitID] == null) {
      _habitMap[habitID] = false;
    }
    return CheckboxListTile(
      title: Text(habitName,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
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
    print(allHabitList);
    print(allHabitKeys);
    return Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What habits have you completed today?",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 285,
              child: Scrollbar(
                controller: _controller,
                child: SingleChildScrollView(
                  controller: _controller,
                  child: Column(
                    children: [
                      for (var i = 0; i < allHabitList.length; i++)
                        _makeHabitCheckbox(setState, allHabitList[i].title,
                            allHabitList[i].id),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                const Spacer(),
                TextButton(
                  child: const Text('Save',
                  style: TextStyle(
                    fontSize: 20,
                  )),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: const Color.fromRGBO(2, 152, 89, 1),
                    elevation: 5,
                    fixedSize: const Size(75, 50),
                  ),
                  onPressed: () async {
                    List completedHabitsAndCount =
                        await logHabitToDB(_habitMap);
                    widget.saveHabits(completedHabitsAndCount[0],
                      completedHabitsAndCount[1]);
                    },
                    ),
                  ],
                ),
              ],
            ),
      );
  }
}



