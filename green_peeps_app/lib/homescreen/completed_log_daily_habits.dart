import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompletedLogDailyHabits extends StatefulWidget {

  final List completedHabits;
  final int pointsGained;
  final VoidCallback quit;
  final VoidCallback addNew;
  const CompletedLogDailyHabits(
      {Key? key,
      required this.completedHabits,
      required this.pointsGained,
      required this.quit,
      required this.addNew})
      : super(key: key);

  @override
  State<CompletedLogDailyHabits> createState() => _CompletedLogDailyHabitsState();
}

class _CompletedLogDailyHabitsState extends State<CompletedLogDailyHabits> {
  final double _boxPadding = 10.0;

  final List<Widget> _buttonRow = [];

  Widget _completedHabitsList(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (String completedHabitText in widget.completedHabits)
          Text("• " + completedHabitText,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool addingNewHabit = widget.completedHabits.isNotEmpty;
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
    if (addingNewHabit) {
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
          SizedBox(
            height: 355,
            child: Column(children: [
              const Spacer(),
              Text(
                "Thank you for logging your daily habits! "
                "You have received ${widget.pointsGained} points.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Visibility(
                visible: addingNewHabit,
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: 250,
                  child: SingleChildScrollView(
                    child: _completedHabitsList(),
                  ),
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
