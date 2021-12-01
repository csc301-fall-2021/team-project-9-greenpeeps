import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_peeps_app/habits/habit_info_dialog.dart';

class TitleBox extends StatefulWidget {
  const TitleBox({Key? key}) : super(key: key);

  @override
  _TitleBoxState createState() => _TitleBoxState();
}

class _TitleBoxState extends State<TitleBox> {
  // Box Variables
  final double _boxPadding = 10.0;
  final double _boxElevation = 5.0; // The height of shadow beneath box
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);

  Widget _buildTitleBox(BuildContext context, double boxPadding,
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
                children: [
                  const Text(
                    "Habits",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: const Icon(Icons.help_outline_rounded,
                      size: 30,
                    ),
                    tooltip: 'Help',
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return HabitInfoDialog();
                          }
                      );
                    },
                  ),
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
    return _buildTitleBox(context, _boxPadding, _boxElevation, _boxColor);
  }
}
