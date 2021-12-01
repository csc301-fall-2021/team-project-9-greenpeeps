import 'package:flutter/material.dart';

class HabitProgressBar extends StatefulWidget {
  final int userCompleted;
  final int userTotal;

  const HabitProgressBar(
      {Key? key, required this.userCompleted, required this.userTotal})
      : super(key: key);

  @override
  _HabitProgressBarState createState() => _HabitProgressBarState();
}

class _HabitProgressBarState extends State<HabitProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          // Used to make the bar round
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            backgroundColor: const Color.fromRGBO(180, 180, 180, 1),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            value: widget.userCompleted / widget.userTotal,
            minHeight: 16,
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Text(
            widget.userCompleted.toString() + "/" + widget.userTotal.toString(),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
