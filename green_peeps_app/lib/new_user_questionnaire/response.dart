import 'package:flutter/material.dart';

class Response{
  String userID, qID;
  TimeOfDay timeStamp;
  String answer;

  Response({required this.userID, required this.qID,
    required this.answer, required this.timeStamp});

}