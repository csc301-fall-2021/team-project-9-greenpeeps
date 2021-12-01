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

Future<void> addIncompleteQuestion(String qID) async {}

Future<void> addSkippedQuestion(String qID) async {}

Future<void> _getUserData() async {
  DocumentSnapshot snapshot = await _userDataCollection
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();
  Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
  try {
    userData = UserData(
        incomplete: data!['incompleteQuestions'],
        skipped: data['skippedQuestions']);
  } catch (exception) {
    return;
  }
}

class UserData {
  List<String>? incomplete;
  List<String>? skipped;

  UserData({required this.incomplete, required this.skipped});
}
