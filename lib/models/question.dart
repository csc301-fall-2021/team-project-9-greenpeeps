import 'dart:collection';
import 'package:flutter/foundation.dart';

import '../services/question_firestore.dart';

class QuestionListModel extends ChangeNotifier {
  final List<Future<Question?>> _questions = [];

  QuestionListModel(String id) {
    loadQuestionTree(id);
    addQuestion(id);
  }

  UnmodifiableListView<Future<Question?>> get questionList {
    return UnmodifiableListView(_questions);
  }

  void addQuestion(String id) async {
    Future<Question?> question = getQuestion(id);
    _questions.add(question);
    notifyListeners();
  }
}

class Question {
  final String id;
  final String text;
  // The type of field to be displayed.
  //
  // 0: Text
  // 1: Multiple choice
  // 2: Dropdown
  final int fieldType;
  // The type of question.
  //
  // 0: Branching
  // 1: BaseValue
  // 2: Modifier
  final int type;
  final List<String> tags;
  final List<Answer> answers;

  Question(
      {required this.id,
      required this.text,
      required this.fieldType,
      required this.type,
      required this.tags,
      required this.answers});

  String getId() => id;

  String getText() => text;

  int getFieldType() => fieldType;

  int getType() => type;

  List<String> getAnswerText() {
    var answersList = <String>[];
    for (var answer in answers) {
      answersList.add(answer.text);
    }
    return answersList;
  }

  List<String> getTags() => tags;
}

class Answer {
  final String text;
  final int? value;
  final String? nextQuestion;

  Answer({required this.text, this.value, this.nextQuestion});
}
