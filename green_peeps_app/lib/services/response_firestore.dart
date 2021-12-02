import 'package:firebase_auth/firebase_auth.dart';

import '../models/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference _userCollection =
    FirebaseFirestore.instance.collection('users');

List<Response>? _cachedResponses;

Future<List<Response>?> getResponses() async {
  if (_cachedResponses != null) {
    return _cachedResponses;
  } else {
    return _getResponsesFromStore(FirebaseAuth.instance.currentUser!.uid);
  }
}

Future<void> saveResponses(List<Response> responses) async {
  var futures = <Future>[];
  for (Response response in responses) {
    _cacheResponse(response);
    futures.add(
        sendResponseToStore(FirebaseAuth.instance.currentUser!.uid, response));
  }
  Future.wait(futures);
}

void _cacheResponse(Response response) {
  if (_cachedResponses != null) {
    int index = _cachedResponses!.indexOf(response);
    if (index == -1) {
      _cachedResponses!.add(response);
    } else {
      _cachedResponses![index] = response;
    }
  }
}

Future<List<Response>?> _getResponsesFromStore(String userId) async {
  DocumentReference responseDoc = _userCollection.doc(userId);
  CollectionReference userResponses = responseDoc.collection('responses');
  QuerySnapshot snapshot = await userResponses.get();
  try {
    List<Response>? responses = snapshot.docs
        .map((doc) => Response(
            qID: doc.id,
            answer: (doc.data() as Map<String, dynamic>)['answer'].toString()))
        .toList();
    _cachedResponses = responses;
    return _cachedResponses;
  } catch (exception) {
    return null;
  }
}

Future<void> sendResponseToStore(String userId, Response response) async {
  DocumentReference responseDoc = _userCollection.doc(userId);
  CollectionReference userResponses = responseDoc.collection('responses');
  return userResponses
      .doc(response.qID)
      .set({'answer': response.answer, 'timestamp': response.timeStamp});
}
