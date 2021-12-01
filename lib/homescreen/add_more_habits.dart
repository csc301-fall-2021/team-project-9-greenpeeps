import 'package:flutter/material.dart';
import 'package:green_peeps_app/habits/new_habit_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddHabit extends StatefulWidget {
  final String hid;
  final String title;
  final String info;
  final int amount;
  final int points;

  const AddHabit(
      {Key? key,
      required this.hid,
      required this.title,
      required this.info,
      required this.amount,
      required this.points})
      : super(key: key);

  @override
  _AddHabitState createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: 12,
    ),
    primary: const Color.fromRGBO(2, 152, 89, 1),
    maximumSize: const Size(150, 60),
    minimumSize: const Size(150, 60),
  );
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
      content: Text('Added \"${widget.title}\" to your Habits In Progress'),
    );

    SnackBar addedCompletedHabitSnackBar = SnackBar(
      content: Text('Added \"${widget.title}\" to your Completed Habits '),
    );

    return SizedBox(
      height: 415,
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: 355,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: NewHabitCard(
                    title: widget.title,
                    info: widget.info,
                    amount: widget.amount,
                    points: widget.points),
              ),
            ),
          ),
          const Spacer(),
          Row(
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
                  'I already have this Habit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
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
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
