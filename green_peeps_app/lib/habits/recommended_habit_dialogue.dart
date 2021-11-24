import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecommendedHabitDialogue extends StatefulWidget {
  final String title;
  final String info;
  final int amount;
  final int points;

  const RecommendedHabitDialogue({Key? key, required this.title, required this.info, required this.amount, required this.points}) : super(key: key);

  @override
  _RecommendedHabitDialogueState createState() => _RecommendedHabitDialogueState();
}

class _RecommendedHabitDialogueState extends State<RecommendedHabitDialogue> {
  final double _boxPadding = 10.0;
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);
  
  @override
  Widget build(BuildContext context) {
    return Dialog( 
      backgroundColor: _boxColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(_boxPadding + 5),
        width: double.infinity,
        height: 535,
        child: Column(
          children: [
            Text(widget.title),
            Text(widget.info),
            Text(widget.amount.toString()),
            Text(widget.points.toString()),
          ]
        )
      )
    );
  }
}