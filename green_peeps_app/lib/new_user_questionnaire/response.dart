import 'package:flutter/material.dart';

class Response{
  String userID, qID, answer;
  TimeOfDay timeStamp;
  double value;

  Response({required this.userID, required this.qID, required this.answer,
    required this.timeStamp, required this.value});

}