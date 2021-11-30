import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompletedLogHabits extends StatefulWidget {

  final List completedHabits;
  final int pointsGained;
  final VoidCallback quit;
  const CompletedLogHabits(
      {Key? key,
        required this.completedHabits,
        required this.pointsGained,
        required this.quit})
      : super(key: key);

  @override
  State<CompletedLogHabits> createState() => _CompletedLogHabitsState();
}

class _CompletedLogHabitsState extends State<CompletedLogHabits> {
  final double _boxPadding = 10.0;
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);

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
                "Thank you for logging your habits! "
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
                  height: min(250, widget.completedHabits.length * 75),
                  child: SingleChildScrollView(
                    child: _completedHabitsList(),
                  ),
                ),
              ),
              const Spacer(),
            ]),
          ),
          Row(children:[
            Spacer(),
            TextButton(
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
            ),
           ]),
        ],
      ),
    );
  }
}



