import 'package:flutter/material.dart';
import 'package:green_peeps_app/models/question.dart';
import 'package:provider/provider.dart';
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
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => QuestionListModel('F3Ct0WCqgIaAlkdrqE7X'),
        child: Consumer<QuestionListModel>(
            builder: (context, questionList, child) {
          return ListView(children: <Widget>[
            Column(
              children: questionList.questionList
                  .map((question) => QuestionnaireCard(
                      question: question,
                      response:
                          Response(userID: userID, qID: question.getId())))
                  .toList(),
            )
          ]);
        }));
  }
}
