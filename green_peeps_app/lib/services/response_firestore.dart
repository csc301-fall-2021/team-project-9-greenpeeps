import '../models/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference _responseCollection =
    FirebaseFirestore.instance.collection('responses');

Future<void> sendResponseToStore(String userId, Response response) async {
  DocumentReference responseDoc = _responseCollection.doc(userId);
  responseDoc.set({'lastResponse': response.qID});
  CollectionReference userResponses = responseDoc.collection('responses');
  return userResponses
      .doc(response.qID)
      .set({'answer': response.answer, 'timestamp': response.timeStamp});
  ;
}
