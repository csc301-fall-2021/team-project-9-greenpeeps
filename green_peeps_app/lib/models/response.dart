import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../services/response_firestore.dart';

class ResponseListModel {
  final List<Response> _responses = [];

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

  Future<void> saveResponsesToStore() async {
    String uID =
        FirebaseAuth.instance.currentUser!.uid; // TODO: Handle null case
    var futures = <Future>[];
    for (Response response in _responses) {
      futures.add(sendResponseToStore(uID, response));
    }
    Future.wait(futures);
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
