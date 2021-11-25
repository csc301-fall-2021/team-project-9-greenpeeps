import 'package:flutter/material.dart';
import 'package:green_peeps_app/models/question.dart';
import 'package:green_peeps_app/models/response.dart';
import 'package:provider/provider.dart';
import 'package:green_peeps_app/questionnaire/questionnaire_card.dart';

class DailyQuestionQuestion extends StatefulWidget {
  final Question question;
  final VoidCallback skipQuestion;
  final VoidCallback saveQuestion;
  const DailyQuestionQuestion({Key? key, required this.question,
    required this.skipQuestion, required this.saveQuestion }) : super(key: key);

  @override
  _DailyQuestionQuestionState createState() => _DailyQuestionQuestionState();
}

class _DailyQuestionQuestionState extends State<DailyQuestionQuestion> {

  _setProgress(setState){

  }



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
            child: Consumer<QuestionListModel>(
                builder: (context, questionListModel, child) {
                  return Container(
                    height: 550,
                    child: Column(
                      children: [
                        Container( // NOTE: questions are scollable but buttons are not!
                          height: 500,
                          child: SingleChildScrollView(
                            child: Column(children: [
                              for (Question question in questionListModel.questionList)
                                QuestionnaireCard(question: question)
                            ]
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                            TextButton(
                              child: const Text('Skip Question'),
                              onPressed: () {
                                widget.skipQuestion();
                              },
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: const Color.fromRGBO(2, 152, 89, 1),
                                elevation: 5,
                                fixedSize: const Size(146, 42),
                              )
                            ),
                            Spacer(),
                            TextButton(
                              child: const Text('Save & Continue'),
                              onPressed: () {
                                widget.saveQuestion();
                              },
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: const Color.fromRGBO(2, 152, 89, 1),
                                elevation: 5,
                                fixedSize: const Size(146, 42),
                              ),
                            )

                            ],
                          ),
                        )
                        // TODO skip button // save and continue button
                      ],
                    ),
                  );
                }),
          ),
        ),
      );



  }
}



