import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

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

  final ButtonStyle style =
        ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            fontSize: 12,
          ),
          primary: Colors.green,
          maximumSize: const Size(120, 50),
          minimumSize: const Size(120, 50),
        );
  
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              elevation: 0,
              toolbarHeight: 30,
              backgroundColor: _boxColor,
              automaticallyImplyLeading: false, // No back arrow
              actions: <Widget>[
                IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.of(context).pop(); // Closes popup
                  },
                  icon: const Icon(Icons.close),
                  color: Colors.black,
                  splashRadius: 15,
                )
              ],
            ),

            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Leaves: " + widget.points.toString()
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                widget.info
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Do this habit " + widget.amount.toString() + " times"
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: style,
                    onPressed: () {},
                    child: const Text(
                      'I already added this Habit',
                      textAlign: TextAlign.center,
                      ),
                  ),
                  ElevatedButton(
                    style: style,
                    onPressed: () {},
                    child: const Text(
                      'Add this to My Habits',
                      textAlign: TextAlign.center
                    ),
                  ),
                ]
              ),
            ),
            
          ]
        )
      )
    );
  }
}