import 'dart:collection';
import 'package:flutter/foundation.dart';

class Habit {
  final String id;
  final String title;
  final String info;
  final String hid;
  final int amount;
  final int points;

  Habit(
      {required this.id,
      required this.title,
      required this.info,
      required this.hid,
      required this.amount,
      required this.points});

  String getID() => id;
  String getTitle() => title;
  String getInfo() => info;
  String getHID() => hid;
  int getAmount() => amount;
  int getPoints() => points;
}
