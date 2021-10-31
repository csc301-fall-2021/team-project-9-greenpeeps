import 'package:flutter/material.dart';
import 'package:green_peeps_app/models/question.dart';
import 'package:green_peeps_app/models/response.dart';
import 'package:provider/provider.dart';
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
            child: Scaffold(
              backgroundColor: Colors.transparent,
              floatingActionButton: Consumer<ResponseListModel>(
                  builder: (context, responseListModel, child) {
                return FloatingActionButton.extended(
                  onPressed: () {
                    responseListModel.saveResponsesToStore();
                    Navigator.popAndPushNamed(context, '/nav');
                  },
                  label: const Text(
                    "Save & Quit",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  backgroundColor: Colors.green,
                );
              }),
              body: SingleChildScrollView(
                  child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.purple])),
                child: Consumer<QuestionListModel>(
                    builder: (context, questionListModel, child) {
                  return Column(children: [
                    for (Question question in questionListModel.questionList)
                      QuestionnaireCard(question: question),
                    SizedBox(height: 600) // TODO remove
                  ]);
                }),
              )),
            ),
          ),
        ));
  }
}
