import '../models/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference _questions =
    FirebaseFirestore.instance.collection('questions');

final Map<String, Future<Question?>> _cachedQuestions = {};

void loadQuestionTree(String documentId) async {
  Future<Question?> future = getQuestionFromStore(documentId);
  _cachedQuestions[documentId] = future;
  Question? question = await future;
  if (question != null) {
    for (Answer answer in question.answers) {
      if (answer.nextQuestion != null) {
        loadQuestionTree(answer.nextQuestion!);
      }
    }
  }
}

void clearQuestionCache() {
  _cachedQuestions.clear();
}

Future<Question?> getQuestion(String documentId) async {
  if (_cachedQuestions.containsKey(documentId)) {
    return _cachedQuestions[documentId];
  } else {
    return await getQuestionFromStore(documentId);
  }
}

Future<Question?> getQuestionFromStore(String documentId) async {
  var snapshot = await _questions.doc(documentId).get();

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
  var answers = await _questions.doc(documentId).collection("answers").get();
  List<Answer> answerList = [];
  for (var snapshot in answers.docs) {
    Map<String, dynamic> data = snapshot.data();
    Answer answer = Answer(
        text: data['text'],
        value: data['value'],
        nextQuestion: data['next']?.toString());
    answerList.add(answer);
  }

  return answerList;
}
