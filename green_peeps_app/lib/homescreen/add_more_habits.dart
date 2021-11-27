import 'package:flutter/material.dart';
import 'package:green_peeps_app/habits/new_habit_card.dart';

class AddHabit extends StatefulWidget {
  const AddHabit({Key? key, required this.title,
    required this.info,
    required this.amount,
    required this.points}) : super(key: key);
  final String title;
  final String info;
  final int amount;
  final int points;

  @override
  _AddHabitState createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  final ButtonStyle style =
  ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: 12,
    ),
    primary:  const Color.fromRGBO(2, 152, 89, 1),
    maximumSize: const Size(150, 60),
    minimumSize: const Size(150, 60),
  );


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 415,
      child: Column(
        children: [
          Spacer(),
          Container(
            height: 355,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: NewHabitCard(title: widget.title,
                    info: widget.info,
                    amount: widget.amount,
                    points: widget.points),
              ),
            ),
          ),
          Spacer(),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  style: style,
                  onPressed: () {},
                  child: const Text(
                    'I already have this Habit',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  style: style,
                  onPressed: () {},
                  child: const Text(
                    'Add this to My Habits',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]
          ),
        ],
      )
    );
  }
}

