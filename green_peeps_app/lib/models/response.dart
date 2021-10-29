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

  void saveResponses() {
    for (Response response in _responses) {
      sendResponseToStore("test_user", response);
    }
  }
}

class Response {
  String qID;
  DateTime timeStamp = DateTime.now();
  String answer;
  Response({required this.qID, this.answer = ""});
}
