import 'package:flutter/material.dart';

class HabitTileInfo extends StatefulWidget {
  final int habitNum;
  final String habitName;

  const HabitTileInfo(
      {Key? key, required this.habitNum, required this.habitName})
      : super(key: key);

  @override
  _HabitTileInfoState createState() => _HabitTileInfoState();
}

class _HabitTileInfoState extends State<HabitTileInfo> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          widget.habitNum.toString() + ") " + widget.habitName,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Expanded(
          child: Divider(),
        ),
        IconButton(
          splashRadius: 15,
          onPressed: () {},
          icon: const Icon(
            Icons.short_text_rounded,
          ),
        )
      ],
    );
  }
}
