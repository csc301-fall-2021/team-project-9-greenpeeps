import 'package:flutter/material.dart';

class AddDailyHabitsDialogue extends StatefulWidget {
  const AddDailyHabitsDialogue({Key? key}) : super(key: key);

  @override
  _AddDailyHabitsDialogueState createState() => _AddDailyHabitsDialogueState();
}

class _AddDailyHabitsDialogueState extends State<AddDailyHabitsDialogue> {
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);
  Map<int, bool> _habitMap = {};

  List habitList = [
    "Use Kettle",
    "Turn off Lights",
    "Recycle",
    "Turn off Computer",
    "Be Green",
    "Filler 1",
    "Filler 2",
    "Be cool",
    "B)))"
  ];

  Widget _makeHabitCheckbox(setState, String habitName, int habitID) {
    if (_habitMap[habitID] == null) {
      _habitMap[habitID] = false;
    }
    return CheckboxListTile(
      title: Text(habitName),
      activeColor: const Color.fromRGBO(0, 154, 6, 1),
      controlAffinity: ListTileControlAffinity.leading,
      value: _habitMap[habitID],
      onChanged: (bool? value) {
        setState(
          () {
            int count = 0;
            for (bool value in _habitMap.values) {
              if (value) {
                count++;
              }
            }
            if (count < 4 || value == false) {
              _habitMap[habitID] = value!;
            }
          },
        );
      },
    );
  }

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
        padding: EdgeInsets.all(15),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                title: Text(
                  "",
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
                child: const Text(
                  "Which habits do you want to appear on your homescreen?",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: const Text(
                  "Limit: 10",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 300,
                child: SingleChildScrollView(
                  child: Column(children: [
                    for (var i = 0; i < habitList.length; i++)
                      _makeHabitCheckbox(setState, habitList[i], i),
                  ]),
                ),
              ),
              Row(
                children: <Widget>[
                  const Spacer(),
                  TextButton(
                    child: const Text('Save'),
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: const Color.fromRGBO(2, 152, 89, 1),
                      elevation: 5,
                      fixedSize: const Size(61, 25),
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
