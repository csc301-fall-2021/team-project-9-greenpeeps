import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_peeps_app/habits/habit_buttons.dart';
import 'package:green_peeps_app/habits/habit_tiles.dart';

class HabitsInProgressSection extends StatefulWidget {
  const HabitsInProgressSection({Key? key}) : super(key: key);

  @override
  _HabitsInProgressSectionState createState() =>
      _HabitsInProgressSectionState();
}

class _HabitsInProgressSectionState extends State<HabitsInProgressSection> {
  Widget _buildHabitsInProgressSection(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Habits In Progress",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              HabitButtons(),
              Divider(),
              Material(
                color: const Color.fromRGBO(248, 244, 219, 1),
                borderRadius: BorderRadius.circular(5.0),
                elevation: 5,
                child: HabitTiles(),
              ),
            ],
          );
        },
        childCount: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildHabitsInProgressSection(context);
  }
}
