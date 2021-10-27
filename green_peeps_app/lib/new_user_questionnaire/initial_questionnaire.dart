import 'package:flutter/material.dart';
import '../models/question.dart';
import '../services/question_firestore.dart';
import '../questionnaire/response.dart';
import 'questionnaire_card.dart';

class InitialQuestionnaire extends StatefulWidget {
  const InitialQuestionnaire({Key? key}) : super(key: key);

  @override
  _InitialQuestionnaireState createState() => _InitialQuestionnaireState();
}

class _InitialQuestionnaireState extends State<InitialQuestionnaire> {
  @override
  String userID = "u1";

  @override
  initState() {
    super.initState();
    _addQuestion('F3Ct0WCqgIaAlkdrqE7X');
  }

  // progress bar to show you how many questions have left
  // screen after a certain amount of questions
  // that tells you finished the general questionnaire
  // then you can complete a more comprehensive questionnaire too
  // (continue more questions)
  @override
  Widget build(BuildContext context) { // add extra instruction card
    return ListView(
        children: <Widget>[
          Column(
            children: _questionList
                .map((question) => QuestionnaireCard(
                    question: question,
                    response: Response(userID: userID, qID: question.getId())))
                .toList(),
          )
    ]);
  }

  final List<Question> _questionList = [];

  void _addQuestion(String id) async {
    Question? question = await getQuestionFromStore(id);
    if (question != null) {
      setState(() {
        _questionList.add(question);
      });
    }
  }
}
