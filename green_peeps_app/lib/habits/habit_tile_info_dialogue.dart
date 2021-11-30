import 'package:flutter/material.dart';

class HabitTileDialogue extends StatefulWidget {
  final String habitName;
  final String habitDescription;

  const HabitTileDialogue(
      {Key? key, required this.habitName, required this.habitDescription})
      : super(key: key);

  @override
  _HabitTileDialogueState createState() => _HabitTileDialogueState();
}

class _HabitTileDialogueState extends State<HabitTileDialogue> {
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(15),
      backgroundColor: _boxColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              title: Text(
                widget.habitName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                widget.habitDescription,
              ),
            ),
            Row(
              children: <Widget>[
                const Spacer(),
                TextButton(
                  child: const Text(
                    'Delete Habit',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: const Color.fromRGBO(2, 152, 89, 1),
                    elevation: 5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
