import 'package:flutter/material.dart';
import 'package:green_peeps_app/habits/completed_log_habits_dialogue.dart';
import 'package:green_peeps_app/habits/log_all_habits.dart';
import 'package:green_peeps_app/services/habit_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogAllHabitsDialogue extends StatefulWidget {
  const LogAllHabitsDialogue({Key? key}) : super(key: key);

  @override
  _LogAllHabitsDialogueState createState() => _LogAllHabitsDialogueState();
}

class _LogAllHabitsDialogueState extends State<LogAllHabitsDialogue> {
  final double _boxPadding = 10.0;
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);
  final ScrollController _controller = ScrollController();
  int _popupIndex = 0;
  List<Widget> _popupViews = [];

  void _addCompletedHabits(habitList, count) {
    _popupViews.add(CompletedLogHabits(
        completedHabits: habitList,
        pointsGained: count,
        quit: () {
          Navigator.of(context).pop(); // Closes popup
        }
      )
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

  @override
  Widget build(BuildContext context) {
    _popupViews.add(LogAllHabits(
      saveHabits: (habitList, count) {
        _addCompletedHabits(habitList, count);
        _nextPage(setState);
      },
    ));

    return Dialog(
      insetPadding: EdgeInsets.all(15),
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
            // const Expanded(child: Divider()),
          ],
        ),
      ),
    );
  }
}
