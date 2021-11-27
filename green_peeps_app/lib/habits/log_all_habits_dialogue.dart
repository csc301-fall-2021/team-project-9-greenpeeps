import 'package:flutter/material.dart';

class LogAllHabitsDialogue extends StatefulWidget {
  const LogAllHabitsDialogue({Key? key}) : super(key: key);

  @override
  _LogAllHabitsDialogueState createState() => _LogAllHabitsDialogueState();
}

class _LogAllHabitsDialogueState extends State<LogAllHabitsDialogue> {
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);
  final ScrollController _controller = ScrollController();

  // Map of which checkboxes are checked
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
            _habitMap[habitID] = value!;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(15),
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
              title: const Text(
                "",
                style: TextStyle(
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
            Column(
              children: [
                const Text(
                  "What habits have you completed today?",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 415,
                  child: Scrollbar(
                    controller: _controller,
                    child: SingleChildScrollView(
                      controller: _controller,
                      child: Column(
                        children: [
                          for (var i = 0; i < habitList.length; i++)
                            _makeHabitCheckbox(setState, habitList[i], i),
                        ],
                      ),
                    ),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
