import 'dart:collection';
import 'package:flutter/foundation.dart';

class Habit {
  final String id;
  final String title;
  final String info;
  final String hid;
  int reps;
  final int totalAmount;
  final int points;

  Habit(
      {required this.id,
      required this.title,
      required this.info,
      required this.hid,
      this.reps = 0,
      required this.totalAmount,
      required this.points});

  String getID() => id;
  String getTitle() => title;
  String getInfo() => info;
  String getHID() => hid;
  int getReps() => reps;
  int getTotalAmount() => totalAmount;
  int getPoints() => points;
}
