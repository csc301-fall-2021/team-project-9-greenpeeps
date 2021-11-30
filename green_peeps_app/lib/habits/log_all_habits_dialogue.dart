import 'package:flutter/material.dart';
import 'package:green_peeps_app/habits/completed_log_habits_dialogue.dart';
import 'package:green_peeps_app/services/habit_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogAllHabitsDialogue extends StatefulWidget {
  const LogAllHabitsDialogue({Key? key}) : super(key: key);

  @override
  _LogAllHabitsDialogueState createState() => _LogAllHabitsDialogueState();
}

class _LogAllHabitsDialogueState extends State<LogAllHabitsDialogue> {
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);
  final ScrollController _controller = ScrollController();

  // Map of which checkboxes are checked
  Map<String, bool> _habitMap = {};
  Map<String, String> keyToTitleHabit = {};
  List allHabitKeys = [];
  List allHabitList = [];

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
    return Dialog(
      insetPadding: const EdgeInsets.all(15),
      backgroundColor: _boxColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              title: const Text(
                "",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              elevation: 0,
              toolbarHeight: 30,
              backgroundColor: _boxColor,
              automaticallyImplyLeading: false, // No back arrow
              actions: <Widget>[
                IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.of(context).pop(); // Closes popup
                  },
                  icon: const Icon(Icons.close),
                  color: Colors.black,
                  splashRadius: 15,
                )
              ],
            ),
            Column(
              children: [
                const Text(
                  "What habits have you completed today?",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 315,
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
                      child: const Text('Save'),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: const Color.fromRGBO(2, 152, 89, 1),
                        elevation: 5,
                        fixedSize: const Size(61, 25),
                      ),
                      onPressed: () async {
                        List completedHabitsAndCount =
                            await logHabitToDB(_habitMap);
                        print(completedHabitsAndCount);
                        // Fetch completed list of habit and points gained from variable above

                        Navigator.of(context).pop();
                        showDialog(
                        context: context,
                        builder: (context) {
                          return CompletedLogHabits(
                              completedHabits: completedHabitsAndCount[0],
                              pointsGained: completedHabitsAndCount[1]);
                        },
                        );
                      },

                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
