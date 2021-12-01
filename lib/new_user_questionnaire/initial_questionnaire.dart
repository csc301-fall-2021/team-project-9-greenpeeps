import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:green_peeps_app/homescreen/info_dialog.dart';
import 'package:green_peeps_app/models/question.dart';
import 'package:green_peeps_app/models/response.dart';
import 'package:provider/provider.dart';
import 'package:green_peeps_app/questionnaire/questionnaire_card.dart';
import 'package:green_peeps_app/new_user_questionnaire/initial_questionnaire_info_card.dart';

class InitialQuestionnaire extends StatefulWidget {
  List<String>? remainingQuestions;

  InitialQuestionnaire({Key? key, required this.remainingQuestions})
      : super(key: key);

  @override
  _InitialQuestionnaireState createState() => _InitialQuestionnaireState();
}

class _InitialQuestionnaireState extends State<InitialQuestionnaire> {
  String rootQuestion = "";
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    widget.remainingQuestions ??= [
      'F3Ct0WCqgIaAlkdrqE7X',
      'rxxqFtUd9314aRYB8UiG'
    ];
    rootQuestion = widget.remainingQuestions!.removeLast();
  }

  void _ScrollDown() {
    if (_controller.hasClients) {
      setState(
        () {
          _controller.animateTo(
            _controller.position.maxScrollExtent,
            duration: Duration(seconds: 1),
            curve: Curves.ease,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => QuestionListModel(rootQuestion)),
        Provider(create: (context) => ResponseListModel())
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(212, 240, 255, 1),
          floatingActionButton: Consumer<ResponseListModel>(
              builder: (context, responseListModel, child) {
            return Consumer<ResponseListModel>(
              builder: (context, responseListModel, child) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    // fit: StackFit.expand,
                    children: [
                      Spacer(),
                      FloatingActionButton.extended(
                        heroTag: null,
                        onPressed: () {
                          // TODO skip question / add new question to list
                          // note that this would have to somehow tell build_question_card
                          // to no longer accept questions
                          // or you need to insert the follow up questions from the skipped question
                          // above new questions if the user decides to answer the skipped question
                          // after they said they want to skip it
                          // please ask eryka for clarification
                          _ScrollDown();
                        },
                        label: const Text(
                          "Skip Question",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        backgroundColor: Colors.green,
                      ),
                      Spacer(),
                      FloatingActionButton.extended(
                        onPressed: () {
                          responseListModel.saveResponsesToStore();
                          if (widget.remainingQuestions!.isEmpty) {
                            Navigator.popUntil(context, ModalRoute.withName('/init_questionnaire_intro'));
                            Navigator.popAndPushNamed(context, '/nav');
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return InfoDialog();
                                }
                            );
                          } else {
                            // pushing instead of popping and pushing because the animation looks weird
                            Navigator.pushNamed(
                                context, '/init_questionnaire',
                                arguments: widget.remainingQuestions);
                          }
                        },
                        heroTag: null,
                        label: widget.remainingQuestions!.isEmpty
                            ? const Text(
                                "Save & Quit",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 100),
                                child: const Text("Save & Continue",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                        backgroundColor: Colors.green,
                      )
                    ],
                  ),
                );
              },
            );
          }),
          body: CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color.fromRGBO(212, 240, 255, 1),
                            Color.fromRGBO(177, 157, 255, 1)])),
                  child: Consumer<QuestionListModel>(
                      builder: (context, questionListModel, child) {
                    return Column(children: [
                      for (Future<Question?> question
                          in questionListModel.questionList)
                        QuestionnaireCard(question: question),
                    ]);
                  })),
            )
          ]),
        ),
      ),
    );
  }
}
