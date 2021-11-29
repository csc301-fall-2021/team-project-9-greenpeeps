import 'package:flutter/material.dart';
import 'package:green_peeps_app/homescreen/log_habits.dart';
import 'package:green_peeps_app/homescreen/completed_log_habits.dart';
import 'package:green_peeps_app/homescreen/add_more_habits.dart';

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
  bool addingNewHabit = true;
  void _addCompletedHabits(habitList, count) {
    // todo compute the number of points the user gets
    //  for completing these habits
    _popupViews.add(CompletedLogHabits(
        addingNewHabit: addingNewHabit,
        completedHabits: habitList,
        pointsGained: count,
        quit: () {
          Navigator.of(context).pop(); // Closes popup
        },
        addNew: () {
          _addNewHabit();
          _nextPage(setState);
        }));
  }

  void _addNewHabit() {
    _popupViews.add(const AddHabit(
        title: "Bike to work",
        info:
            "Driving everyday contributes to producing more CO2 which has a huge effect on the environment. The best way is drive less when possible.",
        // "I am writing even more words in an effort to see what this looks like. Hi mom!!!! how are you doing today?",
        amount: 4,
        points: 5));
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
    if (_popupViews.length == 0) {
      _popupViews.add(LogHabits(
        saveHabits: (habitList, count) {
          _addCompletedHabits(habitList, count);
          _nextPage(setState);
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    _addLogHabits();
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
