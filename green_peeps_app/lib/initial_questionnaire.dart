import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'new_user_questionnaire/question.dart';
import 'new_user_questionnaire/response.dart';
import 'new_user_questionnaire/questionnaire_card.dart';


class InitialQuestionnaire extends StatefulWidget {
  const InitialQuestionnaire({Key? key}) : super(key: key);

  @override
  _InitialQuestionnaireState createState() => _InitialQuestionnaireState();
}

class _InitialQuestionnaireState extends State<InitialQuestionnaire> {
  @override
  String userID = "u1";

  static Tuple2<double, List<String>> q1AnswerYes = Tuple2(1, ["q2"]);
  static Tuple2<double, List<String>> q1AnswerNo = Tuple2(1, []);
  static Tuple2<double, List<String>> q2AnswerGood = Tuple2(2, ["q3"]);
  static Tuple2<double, List<String>> q2AnswerOkay = Tuple2(6, ["q3"]);
  static Tuple2<double, List<String>> q2AnswerBad = Tuple2(10, ["q3"]);
  static Tuple2<double, List<String>> q3AnswerDefault = Tuple2(10, []);

  List<Question> questions = [
    Question(id: "q1", text: "Do you own a car?", fieldType: 1, type: 0,
    tags: ["Travel"], answers: {"Yes": q1AnswerYes, "No": q1AnswerNo}),
    Question(id: "q2", text: "What type of car do you have?",
        fieldType: 2, type: 2, tags: ["Travel"],
        answers: {"A good car": q2AnswerGood,
        "An okay car": q2AnswerOkay, "A bad car": q2AnswerBad}),
    Question(id: "q3", text: "How far do you drive everyday?",
        fieldType: 0, type: 1, tags: ["Travel"],
        answers: {"default": q3AnswerDefault}),
  ];


  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
          Column(
            children: questions.map((question) =>
                QuestionnaireCard(question: question,
                response: Response(userID: userID, qID: question.getId()))).toList(),
          )
        ]
    );
  }
}
