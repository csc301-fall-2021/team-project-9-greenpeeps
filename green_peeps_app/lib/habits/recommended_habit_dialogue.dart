import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class RecommendedHabitDialogue extends StatefulWidget {
  final String hid;
  final String title;
  final String info;
  final int amount;
  final int points;

  const RecommendedHabitDialogue(
      {Key? key,
      required this.hid,
      required this.title,
      required this.info,
      required this.amount,
      required this.points})
      : super(key: key);

  @override
  _RecommendedHabitDialogueState createState() =>
      _RecommendedHabitDialogueState();
}

class _RecommendedHabitDialogueState extends State<RecommendedHabitDialogue> {
  final double _boxPadding = 10.0;
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);

  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: 12,
    ),
    primary: Colors.green,
    maximumSize: const Size(150, 75),
    minimumSize: const Size(150, 75),
  );

  // dev testing: "nFSUjg7UBookPXllvk0d"
  // prod: FirebaseAuth.instance.currentUser!.uid

  _generateHabitDict(int habitAmount) {
    Map<dynamic, dynamic> habitMap = <dynamic, dynamic>{
      'userCompleted': 0,
      'repsLeft': habitAmount,
      'completed': false,
      'isDailyHabit': false,
      'isDailyCompleted': false
    };
    // add with hid as key
    return habitMap;
  }

  _generateCompletedHabitDict() {
    Map<dynamic, dynamic> habitMap = <dynamic, dynamic>{
      'userCompleted': 0,
      'repsLeft': 0,
      'completed': true,
      'isDailyHabit': false,
      'isDailyCompleted': false
    };
    // add with hid as key
    return habitMap;
  }

  @override
  Widget build(BuildContext context) {
    SnackBar addedHabitInProgressSnackBar = SnackBar(
        content: Text('Added \"${widget.title}\" to your Habits In Progress'));
    SnackBar addedCompletedHabitSnackBar = SnackBar(
        content: Text('Added \"${widget.title}\" to your Completed Habits '));

    return Dialog(
      backgroundColor: _boxColor,
      insetPadding: const EdgeInsets.all(15),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(_boxPadding + 5),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
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
              padding: const EdgeInsets.all(10),
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Leaves: ${widget.points}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                widget.info,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Do this habit ${widget.amount} times",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: style,
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get()
                          .then(
                        (DocumentSnapshot snapshot) {
                          // if allHabits doesn't exist yet
                          if (!(snapshot
                              .data()
                              .toString()
                              .contains("userHabits"))) {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .set({'userHabits': '{}'},
                                    SetOptions(merge: true)).then(
                              (onValue) {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update(
                                  {
                                    'userHabits.' + widget.hid:
                                        _generateCompletedHabitDict()
                                  },
                                );
                              },
                            );

                            // if user already has allHabits
                          } else {
                            // update the appropriate habit inside allHabits
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update(
                              {
                                'userHabits.' + widget.hid:
                                    _generateCompletedHabitDict()
                              },
                            );
                          }
                        },
                      );
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(addedCompletedHabitSnackBar);
                    },
                    child: const Text(
                      'I already preform this habit in my life',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: style,
                    onPressed: () => {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get()
                          .then(
                        (DocumentSnapshot snapshot) {
                          // if user doesn't have allHabits
                          if (!(snapshot
                              .data()
                              .toString()
                              .contains("userHabits"))) {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .set({'userHabits': '{}'},
                                    SetOptions(merge: true)).then(
                              (onValue) {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update(
                                  {
                                    'userHabits.' + widget.hid:
                                        _generateHabitDict(widget.amount)
                                  },
                                );
                              },
                            );

                            // if user already has allHabits
                          } else {
                            // firebase structure automatically prevents repeats additions with the same key
                            // if doesn't already exist
                            if (!(snapshot
                                .get(FieldPath(const ["userHabits"]))
                                .toString()
                                .contains(widget.hid))) {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update(
                                {
                                  'userHabits.' + widget.hid:
                                      _generateHabitDict(widget.amount)
                                },
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(addedHabitInProgressSnackBar);
                            }
                          }
                        },
                      ),
                      Navigator.of(context).pop(),
                    },
                    child: const Text(
                      'Add this to Habits In Progress',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
