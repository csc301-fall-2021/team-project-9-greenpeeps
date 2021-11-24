import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExpandHabitDialogueButton extends StatefulWidget {
  final String title;
  final String info;
  final int amount;
  final int points;

  const ExpandHabitDialogueButton({Key? key, required this.title, required this.info, required this.amount, required this.points}) : super(key: key);

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
        // pop dialogue
      },
    );
  }
}