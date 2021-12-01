import 'package:flutter/material.dart';
import 'package:green_peeps_app/habits/habit_tile_info_dialogue.dart';

class HabitTileInfo extends StatefulWidget {
  final int habitNum;
  final String habitName;
  final String habitDescription;
  final String habitID;

  const HabitTileInfo(
      {Key? key,
      required this.habitNum,
      required this.habitName,
      required this.habitDescription,
      required this.habitID})
      : super(key: key);

  @override
  _HabitTileInfoState createState() => _HabitTileInfoState();
}

class _HabitTileInfoState extends State<HabitTileInfo> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      trailing: const Icon(
        Icons.short_text_rounded,
      ),
      title: Text(
        "${widget.habitNum}) ${widget.habitName}",
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return HabitTileDialogue(
                habitName: widget.habitName,
                habitDescription: widget.habitDescription,
                habitID: widget.habitID);
          },
        );
      },
    );
  }
}
