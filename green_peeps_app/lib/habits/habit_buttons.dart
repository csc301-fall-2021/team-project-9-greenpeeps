import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_peeps_app/habits/add_daily_habits_dialogue.dart';
import 'package:green_peeps_app/habits/log_all_habits_dialogue.dart';

class HabitButtons extends StatefulWidget {
  const HabitButtons({Key? key}) : super(key: key);

  @override
  _HabitButtonsState createState() => _HabitButtonsState();
}

class _HabitButtonsState extends State<HabitButtons> {
  Widget _buildHabitButtons(BuildContext context) {
    return Material(
      color: const Color.fromRGBO(248, 244, 219, 1),
      elevation: 5,
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              tileColor: const Color.fromRGBO(0, 176, 60, 1),
              title: const Text(
                "Set Daily Habits",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: const Icon(
                Icons.add_rounded,
                color: Colors.white,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AddDailyHabitsDialogue();
                  },
                );
              },
            ),
            const Divider(),
            ListTile(
              tileColor: const Color.fromRGBO(0, 176, 60, 1),
              title: const Text(
                "Log All Habits",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: const Icon(
                Icons.create_outlined,
                color: Colors.white,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const LogAllHabitsDialogue();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildHabitButtons(context);
  }
}
