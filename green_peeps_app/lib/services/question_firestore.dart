import '../models/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference _questions =
    FirebaseFirestore.instance.collection('questions');

QuestionMetadata? _cachedMetadata;
final Map<String, Future<Question?>> _cachedQuestions = {};

void loadQuestionTree(String documentId) async {
  Future<Question?> future = _getQuestionFromStore(documentId);
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

Future<QuestionMetadata?> getMetadata() async {
  if (_cachedMetadata != null) {
    return _cachedMetadata;
  } else {
    return _getMetadataFromStore();
  }
}

Future<Question?> getQuestion(String documentId) async {
  if (_cachedQuestions.containsKey(documentId)) {
    return _cachedQuestions[documentId];
  } else {
    return await _getQuestionFromStore(documentId);
  }
}

Future<QuestionMetadata?> _getMetadataFromStore() async {
  var snapshot = await _questions.doc('metadata').get();
  Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
  if (data == null) {
    return null;
  }
  try {
    // all this does is map a <string, list<dynamic>> to a map<string, list<string>>
    Map<String, List<String>> categories = (data['categories']
            as Map<String, dynamic>)
        .map((key, value) => MapEntry(
            key, (value as List<dynamic>).map((e) => e.toString()).toList()));
    _cachedMetadata = QuestionMetadata(categories: categories);
    return _cachedMetadata;
  } catch (exception) {
    return null;
  }
}

Future<Question?> _getQuestionFromStore(String documentId) async {
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
