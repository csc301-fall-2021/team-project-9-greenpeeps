import 'package:flutter/material.dart';
import 'package:green_peeps_app/homescreen/log_habits.dart';
import 'package:green_peeps_app/homescreen/completed_log_daily_habits.dart';
import 'package:green_peeps_app/homescreen/add_more_habits.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class LogHabitPopup extends StatefulWidget {
  const LogHabitPopup({Key? key}) : super(key: key);

  @override
  _LogHabitPopup createState() => _LogHabitPopup();
}

class _LogHabitPopup extends State<LogHabitPopup> {
  // Current index of which popup view to look at
  int _popupIndex = 0;

  // Box Variables
  final double _boxPadding = 10.0;
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);

  // Database Information
  void _addCompletedHabits(habitList, count) {
    _popupViews.add(
      CompletedLogDailyHabits(
        completedHabits: habitList,
        pointsGained: count,
        quit: () {
          Navigator.of(context).pop(); // Closes popup
        },
        addNew: () {
          _popupViews.add(_addNewHabit());
          _nextPage(setState);
        },
      ),
    );
  }

  _getNonUserHabits(AsyncSnapshot<QuerySnapshot> snapshot,
      Stream<DocumentSnapshot> userHabits) {
    // Get all habits
    List<String> testLst = [];
    for (var element in snapshot.data!.docs) {
      testLst.add(element.id);
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: userHabits,
      builder: (context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.active) {
          var userData = userSnapshot.data;

          if (userData!.data().toString().contains('userHabits') == true) {
            Map<String, dynamic> userHabitsMap =
                userData.data() as Map<String, dynamic>;
            var userHabitKeys = userHabitsMap['userHabits'].keys.toList();
            var nonUserHabits = _filterHabits(snapshot, testLst, userHabitKeys);
            if (nonUserHabits.length > 0) {
              return nonUserHabits[0];
            } else {
              return const Text("No More Recommendations");
            }
          } else {
            return const Text("No More Recommendations");
          }
        } else {
          return const Text("No More Recommendations");
        }
      },
    );
  }

  _filterHabits(AsyncSnapshot<QuerySnapshot> snapshot,
      List<String> allHabitsList, List<String> userHabitsList) {
    List<String> filteredHabitsList = [];

    // Find habits the user does not already have
    for (var habitKey in allHabitsList) {
      if (!userHabitsList.contains(habitKey)) {
        filteredHabitsList.add(habitKey);
      }
    }
    var habitsList = [];
    for (var doc in snapshot.data!.docs) {
      // should be in filteredhabitslist
      if (filteredHabitsList.contains(doc.id)) {
        habitsList.add(doc);
      }
    }

    // Choose a random habit from that list
    int index = Random().nextInt(filteredHabitsList.length);
    var chosenDoc = habitsList[index];
    List<AddHabit> newHabit = [
      AddHabit(
        hid: chosenDoc.id,
        title: chosenDoc["title"],
        info: chosenDoc["info"],
        amount: chosenDoc["amount"],
        points: chosenDoc["points"],
      ),
    ];
    return newHabit;
  }

  _addNewHabit() {
    Stream<QuerySnapshot> habits =
        FirebaseFirestore.instance.collection('habits').snapshots();
    Stream<DocumentSnapshot> userHabits = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: habits,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 150, vertical: 50),
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        } else {
          return Container(
            child: _getNonUserHabits(snapshot, userHabits),
          );
        }
      },
    );
  }

  // Changes popup view being viewed
  void _nextPage(setState) {
    setState(
      () {
        if (_popupIndex < _popupViews.length - 1) {
          _popupIndex += 1;
        }
      },
    );
  }

  final List<Widget> _popupViews = <Widget>[];

  void _addLogHabits() {
    if (_popupViews.isEmpty) {
      _popupViews.add(
        LogHabits(
          saveHabits: (habitList, count) {
            _addCompletedHabits(habitList, count);
            _nextPage(setState);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _addLogHabits();
    return Dialog(
      insetPadding: const EdgeInsets.all(15),
      backgroundColor: _boxColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(_boxPadding + 5),
        width: double.infinity,
        height: 500,
        child: Column(
          children: <Widget>[
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
            SingleChildScrollView(
              child: _popupViews.elementAt(_popupIndex),
            )
          ],
        ),
      ),
    );
  }
}
