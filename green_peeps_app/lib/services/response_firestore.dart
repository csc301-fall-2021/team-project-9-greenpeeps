import '../models/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference _responseCollection =
    FirebaseFirestore.instance.collection('responses');

Future<void> sendResponseToStore(String userId, Response response) async {
  CollectionReference userResponses =
      _responseCollection.doc(userId).collection('responses');
  return userResponses
      .doc(response.qID)
      .set({'answer': response.answer, 'timestamp': response.timeStamp});
}

Future<void> sendConfirmation(String userId) {
  DocumentReference responseDoc = _responseCollection.doc(userId);
  return responseDoc.set({'lastUpdated': Timestamp.now()});
}
