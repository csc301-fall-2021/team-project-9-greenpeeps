import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final CollectionReference _userDataCollection =
    FirebaseFirestore.instance.collection('users');

UserData? userData;

Future<List<String>?> getIncompleteQuestions() async {
  if (userData == null) {
    await _getUserData();
  }
  return userData?.incomplete;
}

Future<List<String>?> getSkippedQuestions() async {
  if (userData == null) {
    await _getUserData();
  }
  return userData?.skipped;
}

void clearCache() async {
  userData = null;
}

Future<void> addIncompleteQuestion(String qID) async {
  userData?.incomplete.add(qID);
  await _userDataCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
    'incompleteQuestions': FieldValue.arrayUnion([qID])
  });
}

Future<void> addSkippedQuestion(String qID) async {
  userData?.skipped.add(qID);
  await _userDataCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
    'skippedQuestions': FieldValue.arrayUnion([qID])
  });
}

Future<void> setCarbonValue(String category, double value) async {
  await _userDataCollection
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({'carbonEmissions.$category': value});
}

Future<void> _getUserData() async {
  DocumentSnapshot snapshot = await _userDataCollection
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();
  Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
  userData = UserData(
      incomplete: (data?['incompleteQuestions'] as List<dynamic>?)
              ?.map((data) => data.toString())
              .toList() ??
          [],
      skipped: (data?['skippedQuestions'] as List<dynamic>?)
              ?.map((data) => data.toString())
              .toList() ??
          []);
  return;
}

class UserData {
  List<String> incomplete;
  List<String> skipped;

  UserData({required this.incomplete, required this.skipped});
}
