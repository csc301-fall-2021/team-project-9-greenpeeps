import 'package:flutter/material.dart';
import 'package:green_peeps_app/models/question.dart';
import 'package:green_peeps_app/models/response.dart';
import 'package:provider/provider.dart';
import 'package:green_peeps_app/questionnaire/questionnaire_card.dart';

class DailyQuestionQuestion extends StatefulWidget {
  final String question;
  final Function(bool) nextQuestion;
  const DailyQuestionQuestion(
      {Key? key, required this.question, required this.nextQuestion})
      : super(key: key);

  @override
  _DailyQuestionQuestionState createState() => _DailyQuestionQuestionState();
}

class _DailyQuestionQuestionState extends State<DailyQuestionQuestion> {
  _setProgress(setState) {}

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => QuestionListModel(widget.question)),
        Provider(create: (context) => ResponseListModel(widget.question))
      ],
      child: SafeArea(
        child: Container(
          child: Consumer<QuestionListModel>(
              builder: (context, questionListModel, child) {
            return Container(
              height: 515,
              child: Column(children: [
                Container(
                  // NOTE: questions are scollable but buttons are not!
                  height: 455,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      for (Future<Question?> question
                          in questionListModel.questionList)
                        QuestionnaireCard(question: question)
                    ]),
                  ),
                ),
                Spacer(),
                Consumer<ResponseListModel>(
                    builder: (context, responses, child) {
                  return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(children: [
                        TextButton(
                            child: const Text('Skip Question'),
                            onPressed: () {
                              responses.skipCurrent();
                              widget.nextQuestion(true);
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor:
                                  const Color.fromRGBO(2, 152, 89, 1),
                              elevation: 5,
                              fixedSize: const Size(145, 60),
                            )),
                        Spacer(),
                        TextButton(
                          child: const Text('Save & Continue'),
                          onPressed: () {
                            responses.saveCurrent();
                            widget.nextQuestion(false);
                          },
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor:
                                const Color.fromRGBO(2, 152, 89, 1),
                            elevation: 5,
                            fixedSize: const Size(145, 60),
                          ),
                        )
                      ]));
                })
              ]),
            );
          }),
        ),
      ),
    );
  }
}
