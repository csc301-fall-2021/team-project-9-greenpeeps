import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompletedLogHabits extends StatefulWidget {
  final bool addingNewHabit;
  final List completedHabits;
  final int pointsGained;
  final VoidCallback quit;
  final VoidCallback addNew;
  const CompletedLogHabits(
      {Key? key,
      required this.addingNewHabit,
      required this.completedHabits,
      required this.pointsGained,
      required this.quit,
      required this.addNew})
      : super(key: key);

  @override
  State<CompletedLogHabits> createState() => _CompletedLogHabitsState();
}

class _CompletedLogHabitsState extends State<CompletedLogHabits> {
  final double _boxPadding = 10.0;

  final List<Widget> _buttonRow = [];

  @override
  Widget build(BuildContext context) {
    _buttonRow.clear();
    _buttonRow.add(TextButton(
      child: const Text(
        'Done!',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        widget.quit();
      },
      style: TextButton.styleFrom(
        primary: Colors.white,
        backgroundColor: const Color.fromRGBO(2, 152, 89, 1),
        elevation: 5,
        fixedSize: const Size(100, 55),
      ),
    ));
    if (widget.addingNewHabit) {
      _buttonRow.add(const Spacer());
      _buttonRow.add(TextButton(
        child: const Text(
          'Add more habits!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          widget.addNew();
        },
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: const Color.fromRGBO(2, 152, 89, 1),
          elevation: 5,
          fixedSize: const Size(100, 55),
        ),
      ));
    } else {
      _buttonRow.insert(0, const Spacer());
    }

    return Container(
      padding: EdgeInsets.all(_boxPadding + 5),
      width: double.infinity,
      // height: 415,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 355,
            child: Column(children: [
              const Spacer(),
              Text(
                "Thank you for logging your daily habits! "
                "You have received " + widget.pointsGained.toString() + " points.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
            ]),
          ),
          Row(children: _buttonRow),
        ],
      ),
    );
  }
}
