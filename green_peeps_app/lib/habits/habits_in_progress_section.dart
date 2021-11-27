import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_peeps_app/habits/habit_buttons.dart';
import 'package:green_peeps_app/habits/habit_tile_info.dart';
import 'package:green_peeps_app/habits/habit_tile_info_dialogue.dart';
import 'package:green_peeps_app/habits/habit_tile_progress_bar.dart';

List habitList = [
  "Use Kettle",
  "Turn off Lights",
  "Recycle",
];

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
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      "Habits In Progress",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.assignment_rounded,
                    ),
                  ],
                ),
              ),
              const HabitButtons(),
              const Divider(),
              Material(
                color: const Color.fromRGBO(248, 244, 219, 1),
                borderRadius: BorderRadius.circular(5.0),
                elevation: 5,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: habitList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          HabitTileInfo(
                              habitNum: index + 1,
                              habitName: habitList[index],
                              habitDescription: "TBD"),
                          const HabitProgressBar(
                            userCompleted: 2,
                            userTotal: 10,
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    );
                  },
                ),
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
