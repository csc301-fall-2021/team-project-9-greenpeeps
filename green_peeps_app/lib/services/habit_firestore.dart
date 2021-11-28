import '../models/habit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference _habit =
    FirebaseFirestore.instance.collection('habits');

Future<Habit?> getHabitFromStore(String documentId) async {
  var snapshot = await _habit.doc(documentId).get();

  Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
  if (data == null) {
    return null;
  }
  try {
    return Habit(
        id: snapshot.id,
        title: data['title'],
        info: data['info'],
        hid: data['hid'],
        repsLeft: data['amount'],
        totalAmount: data['amount'],
        points: data['points']
    );
  } catch (exception) {
    return null;
  }
}
