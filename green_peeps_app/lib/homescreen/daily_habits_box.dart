import 'package:flutter/material.dart';
import 'package:green_peeps_app/homescreen/habits_popup.dart';

class DailyLogsBox extends StatefulWidget {
  const DailyLogsBox({Key? key}) : super(key: key);

  @override
  _DailyLogsBoxState createState() => _DailyLogsBoxState();
}

class _DailyLogsBoxState extends State<DailyLogsBox> {
  // Box Variables
  final double _boxPadding = 10.0;
  final double _boxElevation = 5.0; // The height of shadow beneath box
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);

  Widget _buildDailyLogsBox(BuildContext context, double boxPadding,
      double boxElevation, Color boxColor) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Material(
            color: boxColor,
            elevation: boxElevation,
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              padding: EdgeInsets.all(boxPadding),
              child: Row(
                mainAxisSize: MainAxisSize
                    .min, // Use the minimum space necessary to fit all widgets
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Everything starts fartest left
                children: <Widget>[
                  const Text(
                    "Log Daily Habits",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      color: Colors.transparent,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        barrierDismissible:
                            false, // Users cannot click off the screen to close popup
                        context: context,
                        builder: (BuildContext context) {
                          return const LogHabitPopup();
                        },
                      );
                    },
                    child: const Text("GO >"),
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(0, 154, 6, 1),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        childCount: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildDailyLogsBox(context, _boxPadding, _boxElevation, _boxColor);
  }
}
