import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class Response {
  String userID, qID;
  DateTime timeStamp = DateTime.utc(1999, 9, 9);
  String answer = "";
  Response({required this.userID, required this.qID});

  void setAnswer(String answer, DateTime timeStamp) {
    this.answer = answer;
    this.timeStamp = timeStamp;
  }
}
