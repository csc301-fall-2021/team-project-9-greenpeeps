import '../models/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference questions =
    FirebaseFirestore.instance.collection('questions');

Future<Question?> getQuestionFromStore(String documentId) async {
  var snapshot = await questions.doc(documentId).get();

  Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
  if (data == null) {
    return null;
  }
  try {
    return Question(
        id: snapshot.id,
        text: data['text'],
        fieldType: data['field_type'],
        type: data['type'],
        tags: List.castFrom(data['tags'] ?? []),
        answers: await _getAnswersFromStore(documentId));
  } catch (exception) {
    return null;
  }
}

Future<List<Answer>> _getAnswersFromStore(String documentId) async {
  var answers = await questions.doc(documentId).collection("answers").get();
  List<Answer> answerList = [];
  for (var snapshot in answers.docs) {
    Map<String, dynamic> data = snapshot.data();
    Answer answer = Answer(
        text: data['text'],
        value: data['value'],
        nextQuestion: data['next'].toString());
    answerList.add(answer);
  }

  return answerList;
}
