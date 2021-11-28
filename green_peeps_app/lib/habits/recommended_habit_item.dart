import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_peeps_app/habits/expand_habit_dialogue_button.dart';
import 'package:green_peeps_app/habits/recommended_habit_dialogue.dart';

class RecommendedHabitItem extends StatefulWidget {
  final String hid;
  final String title;
  final String info;
  final int amount;
  final int points;

  const RecommendedHabitItem({Key? key, required this.hid, required this.title, required this.info, required this.amount, required this.points}) : super(key: key);

  @override
  _RecommendedHabitItemState createState() => _RecommendedHabitItemState();
}

class _RecommendedHabitItemState extends State<RecommendedHabitItem> {

  // Item Variables
  final double _habitItemPadding = 15.0;
  final double _habitItemElevation = 5.0; // The height of shadow beneath box
  final Color _habitItemColor = const Color.fromRGBO(248, 244, 219, 1);
  // pass info to recommended habit item
  // display title inside

  // popup when plus button pressed
  // display info
  // proceed as according to UI


  @override 
  Widget build(BuildContext context) {


    return InkWell(
      onTap: (){
        showDialog(
            context: context,
            builder: (context) {
              return RecommendedHabitDialogue(hid: widget.hid, title: widget.title, info: widget.info, amount: widget.amount, points: widget.points);
            }
        );
      },
      child: Card(
        color: _habitItemColor,
        elevation: _habitItemElevation,
        // borderRadius: BorderRadius.circular(5.0),
        child: Container(
          padding: EdgeInsets.all(_habitItemPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Text(widget.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                ),
              ),
              const Icon(
                Icons.add_circle,
                size: 28,
              ),
              // ExpandHabitDialogueButton(hid: widget.hid, title: widget.title, info: widget.info, amount: widget.amount, points: widget.points),
            ]
          )
        )
      ),
    );
  }
}