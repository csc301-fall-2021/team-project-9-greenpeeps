import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecommendedHabitItem extends StatefulWidget {
  final String title;
  const RecommendedHabitItem({Key? key, required this.title}) : super(key: key);

  @override
  _RecommendedHabitItemState createState() => _RecommendedHabitItemState();
}

class _RecommendedHabitItemState extends State<RecommendedHabitItem> {


  // pass info to recommended habit item
  // display title inside

  // popup when plus button pressed
  // display info
  // proceed as according to UI


  @override 
  Widget build(BuildContext context) {

    return Text(widget.title);
  }
}