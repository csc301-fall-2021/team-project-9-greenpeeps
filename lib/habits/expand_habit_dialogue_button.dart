import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_peeps_app/habits/recommended_habit_dialogue.dart';

class ExpandHabitDialogueButton extends StatefulWidget {
  final String hid;
  final String title;
  final String info;
  final int amount;
  final int points;

  const ExpandHabitDialogueButton({Key? key, required this.hid, required this.title, required this.info, required this.amount, required this.points}) : super(key: key);

  @override
  _ExpandHabitDialogueButtonState createState() => _ExpandHabitDialogueButtonState();
}

class _ExpandHabitDialogueButtonState extends State<ExpandHabitDialogueButton> {

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.add_circle,
      ),
      tooltip: 'Details about this habit',
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return RecommendedHabitDialogue(hid: widget.hid, title: widget.title, info: widget.info, amount: widget.amount, points: widget.points);
          }
        );
      },
    );
  }
}