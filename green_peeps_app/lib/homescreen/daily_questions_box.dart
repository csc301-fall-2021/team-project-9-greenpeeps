import 'package:flutter/material.dart';
// import 'package:green_peeps_app/homescreen/question_popup.dart'; TODO remove
import 'package:green_peeps_app/homescreen/daily_questions_popup.dart';

class DailyQuestionsBox extends StatefulWidget {
  const DailyQuestionsBox({Key? key}) : super(key: key);

  @override
  _DailyQuestionsBoxState createState() => _DailyQuestionsBoxState();
}

class _DailyQuestionsBoxState extends State<DailyQuestionsBox> {
  // Box Variables
  final double _boxPadding = 10.0;
  final double _boxElevation = 5.0; // The height of shadow beneath box
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);

  Widget _buildDailyQuestionsBox(BuildContext context, double boxPadding,
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
                    "Daily Questions",
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
                          return const DailyQuestionsPopup();
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
    return _buildDailyQuestionsBox(
        context, _boxPadding, _boxElevation, _boxColor);
  }
}
