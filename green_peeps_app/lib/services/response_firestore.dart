import '../models/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference _userCollection =
    FirebaseFirestore.instance.collection('users');

Future<void> sendResponseToStore(String userId, Response response) async {
  DocumentReference responseDoc = _userCollection.doc(userId);
  CollectionReference userResponses = responseDoc.collection('responses');
  return userResponses
      .doc(response.qID)
      .set({'answer': response.answer, 'timestamp': response.timeStamp});
}
