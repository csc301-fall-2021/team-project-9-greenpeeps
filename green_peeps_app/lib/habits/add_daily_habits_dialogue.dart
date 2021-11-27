import 'package:flutter/material.dart';
import 'package:green_peeps_app/services/habit_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDailyHabitsDialogue extends StatefulWidget {
  const AddDailyHabitsDialogue({Key? key}) : super(key: key);

  @override
  _AddDailyHabitsDialogueState createState() => _AddDailyHabitsDialogueState();
}

class _AddDailyHabitsDialogueState extends State<AddDailyHabitsDialogue> {
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);
  final ScrollController _controller = ScrollController();
  Map<String, bool> _habitMap = {};

  List habitKeys = [];
  List habitList = [];

  @override
  void initState() {
    super.initState();
    getHabitKeys().then((result) {
      setState(() {
        habitKeys = result;
        for (var key in habitKeys) {
          getHabitFromStore(key).then((r) {
            setState(() {
              habitList.add(r);
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
    if (userSnapshot.exists) {
      habitKeys = userSnapshot['habitInfo'].keys.toList();
      return habitKeys;
    } else {
      return null;
    }
  }

  addHabitToDailyDB(key) async {
    var userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (userSnapshot.exists) {
      var dailyHabits = userSnapshot['dailyHabits'];
      print(dailyHabits);
      dailyHabits[key] = {'completed': true, 'user_completed': 0};
      print(dailyHabits);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'dailyHabits': dailyHabits}).then((value) => {});
    }
  }

  Widget _makeHabitSwitchList(setState, String habitName, String habitID) {
    if (_habitMap[habitID] == null) {
      _habitMap[habitID] = false;
    }
    return SwitchListTile(
      title: Text(habitName),
      activeColor: const Color.fromRGBO(0, 154, 6, 1),
      controlAffinity: ListTileControlAffinity.leading,
      value: _habitMap[habitID]!,
      onChanged: (bool? value) {
        setState(
          () {
            int count = 0;
            for (bool value in _habitMap.values) {
              if (value) {
                count++;
              }
            }
            if (count < 5 || value == false) {
              _habitMap[habitID] = value!;
            }
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const Text(
                "Which habits do you want to appear on your homescreen?",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const Text(
                "Limit: 5",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 300,
              child: Scrollbar(
                controller: _controller,
                child: SingleChildScrollView(
                  controller: _controller,
                  child: Column(
                    children: [
                      for (var i = 0; i < habitList.length; i++)
                        _makeHabitSwitchList(
                            setState, habitList[i].title, habitList[i].id),
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
                  onPressed: () {
                    _habitMap.forEach(
                      (key, value) {
                        if (value) {
                          addHabitToDailyDB(key).then(
                            (value) => {},
                          );
                        }
                      },
                    );
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
        ),
      ),
    );
  }
}
