import 'dart:collection';
import 'package:flutter/foundation.dart';

class Habit {
  final String id;
  final String title;
  final String info;
  final String hid;
  int repsLeft;
  final int totalAmount;
  final int points;

  Habit(
      {required this.id,
      required this.title,
      required this.info,
      required this.hid,
      required this.repsLeft,
      required this.totalAmount,
      required this.points});

  String getID() => id;
  String getTitle() => title;
  String getInfo() => info;
  String getHID() => hid;
  int getReps() => repsLeft;
  int getTotalAmount() => totalAmount;
  int getPoints() => points;
}
