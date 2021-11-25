import 'package:flutter/material.dart';
import 'package:green_peeps_app/models/question.dart';
import 'package:green_peeps_app/models/response.dart';
import 'package:provider/provider.dart';
import 'package:green_peeps_app/questionnaire/questionnaire_card.dart';

class DailyQuestionQuestion extends StatefulWidget {
  final Question question;
  const DailyQuestionQuestion({Key? key, required this.question}) : super(key: key);

  @override
  _DailyQuestionQuestionState createState() => _DailyQuestionQuestionState();
}

class _DailyQuestionQuestionState extends State<DailyQuestionQuestion> {
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);

  List<Question> questionList = [ Question(id: "q1", text: "Do you own a car?", fieldType: 1, type: 0,
      tags: ["Travel"], answers: [Answer(text:"Yes" ), Answer(text:"No" )]),
    Question(id: "q2", text: "What type of car do you have?",
        fieldType: 2, type: 2, tags: ["Travel"],
        answers: [Answer(text:"A good car" ), Answer(text:"A bad car" )]),
    Question(id: "q3", text: "How far do you drive everyday?",
        fieldType: 0, type: 1, tags: ["Travel"],
        answers: [Answer(text:"default" )])];
  // TODO: based on the question, we will have a questionList that will update.
  // This is like initial questionnaire
  // Backend.. do your thinG!

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => QuestionListModel('F3Ct0WCqgIaAlkdrqE7X')),
          Provider(create: (context) => ResponseListModel())
        ],
        child: SafeArea(
          child: Container(
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter,
            //         colors: [Colors.black, Colors.purple])),
            child: SingleChildScrollView(
                child: Consumer<QuestionListModel>(
                    builder: (context, questionListModel, child) {
                      return Column(
                        children: [ // TODO : progress bar,
                          Column(children: [
                            for (Question question in questionListModel.questionList)
                              QuestionnaireCard(question: question)
                          ]
                          ),
                          // TODO skip button // save and continue button
                        ],
                      );
                    })),
          ),
        ),
      );

  //Consumer<ResponseListModel>(
    //                   builder: (context, responseListModel, child) {
    //                     return FloatingActionButton.extended(
    //                       onPressed: () {
    //                         responseListModel.saveResponsesToStore();
    //                         Navigator.popAndPushNamed(context, '/nav');
    //                       },

  }
}



