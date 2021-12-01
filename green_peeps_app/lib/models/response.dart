import 'dart:collection';

import '../services/response_firestore.dart';
import '../services/userdata_firestore.dart';

class ResponseListModel {
  final List<Response> _responses = [];
  String? currentQuestion;

  ResponseListModel(String question) {
    currentQuestion = question;
  }

  UnmodifiableListView get questionList {
    return UnmodifiableListView(_responses);
  }

  void addResponse(Response response) {
    int index = _responses.indexOf(response);
    if (index == -1) {
      _responses.add(response);
    } else {
      _responses[index] = response;
    }
  }

  Future<void> saveCurrent() async {
    if (currentQuestion != null) {
      addIncompleteQuestion(currentQuestion!);
    }
    saveResponses(_responses);
  }

  Future<void> skipCurrent() async {
    if (currentQuestion != null) {
      addSkippedQuestion(currentQuestion!);
    }
  }
}

class Response {
  String qID;
  DateTime timeStamp = DateTime.now();
  String answer;
  Response({required this.qID, this.answer = ""});

  @override
  bool operator ==(Object other) {
    // compare this to other
    return other is Response && qID == other.qID;
  }

  @override
  int get hashCode => qID.hashCode;
}
