import 'dart:collection';
import 'package:flutter/foundation.dart';

import '../services/response_firestore.dart';

class ResponseListModel {
  final List<Response> _responses = [];

  UnmodifiableListView get questionList {
    return UnmodifiableListView(_responses);
  }

  void addResponse(Response response) {
    _responses.add(response);
  }

  Future<void> saveResponses() async {
    String uID = "test_user"; // TODO: Fetch user from state
    var futures = <Future>[];
    for (Response response in _responses) {
      futures.add(sendResponseToStore(uID, response));
    }
    Future.wait(futures);
    sendConfirmation(uID);
  }
}

class Response {
  String qID;
  DateTime timeStamp = DateTime.now();
  String answer;
  Response({required this.qID, this.answer = ""});
}
