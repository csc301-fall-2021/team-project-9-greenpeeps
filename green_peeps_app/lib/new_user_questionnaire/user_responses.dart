import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
import 'package:green_peeps_app/new_user_questionnaire/response.dart';

class UserResponses{
  String id;
  Map<String, List<Tuple2<String, TimeOfDay>>> responses = {};
  // {questionID: [(answer, timeStamp)]}
  // numerical answers are converted to Strings!!!

  UserResponses({required this.id});


  // TODO add get average and potential average to the responses map
  // st it is of the form {questionID: (answer, [(value, timeStamp)])}
  // where answer is a double of the average value
  // double getAverage(String qID){
  //   responses[qID]
  // }

  void addAnswer(Response response){
    if (responses[response.qID] == null){
      responses[response.qID] = [Tuple2(response.answer, response.timeStamp)];
      // maybe we should just put in responses as the value instead of the tuple...
    } else {
      responses[response.qID]?.add(Tuple2(response.answer, response.timeStamp));

    }
  }

}

