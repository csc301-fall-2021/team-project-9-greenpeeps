import 'package:flutter/material.dart';

class MyHabitsEmpty extends StatefulWidget {
  const MyHabitsEmpty({Key? key}) : super(key: key);

  @override
  _MyHabitsEmptyState createState() => _MyHabitsEmptyState();
}

class _MyHabitsEmptyState extends State<MyHabitsEmpty> {
  final double _habitItemPadding = 10.0;
  final double _habitItemElevation = 5.0; // The height of shadow beneath box
  final Color _habitItemColor = const Color.fromRGBO(248, 244, 219, 1);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _habitItemColor,
      elevation: _habitItemElevation,
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        padding: EdgeInsets.all(_habitItemPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Text("You have no completed habits :("),
          ],
        ),
      ),
    );
  }
}
