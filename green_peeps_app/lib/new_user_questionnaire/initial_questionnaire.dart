import 'package:flutter/material.dart';
import 'package:green_peeps_app/homescreen/info_dialog.dart';
import 'package:green_peeps_app/models/question.dart';
import 'package:green_peeps_app/models/response.dart';
import 'package:provider/provider.dart';
import 'package:green_peeps_app/questionnaire/questionnaire_card.dart';

class InitialQuestionnaire extends StatefulWidget {
  List<String>? remainingQuestions;

  InitialQuestionnaire({Key? key, required this.remainingQuestions})
      : super(key: key);

  @override
  _InitialQuestionnaireState createState() => _InitialQuestionnaireState();
}

class _InitialQuestionnaireState extends State<InitialQuestionnaire> {
  String rootQuestion = "";

  @override
  void initState() {
    super.initState();
    widget.remainingQuestions ??= ['has_car', 'eats_meat'];
    rootQuestion = widget.remainingQuestions!.removeLast();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => QuestionListModel(rootQuestion)),
        Provider(create: (context) => ResponseListModel(rootQuestion))
      ],
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(212, 240, 255, 1),
        floatingActionButton: Consumer<ResponseListModel>(
            builder: (context, responseListModel, child) {
          return Consumer<ResponseListModel>(
            builder: (context, responseListModel, child) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  // fit: StackFit.expand,
                  children: [
                    const Spacer(),
                    FloatingActionButton.extended(
                      heroTag: null,
                      onPressed: () {
                        responseListModel.skipCurrent();
                        if (widget.remainingQuestions!.isEmpty) {
                          Navigator.popUntil(context,
                              ModalRoute.withName('/init_questionnaire_intro'));
                          Navigator.popAndPushNamed(context, '/nav');
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const InfoDialog();
                              });
                        } else {
                          // pushing instead of popping and pushing because the animation looks weird
                          Navigator.pushNamed(context, '/init_questionnaire',
                              arguments: widget.remainingQuestions);
                        }
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
                    const Spacer(),
                    FloatingActionButton.extended(
                      onPressed: () {
                        responseListModel.saveCurrent();
                        if (widget.remainingQuestions!.isEmpty) {
                          Navigator.popUntil(context,
                              ModalRoute.withName('/init_questionnaire_intro'));
                          Navigator.popAndPushNamed(context, '/nav');
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const InfoDialog();
                              });
                        } else {
                          // pushing instead of popping and pushing because the animation looks weird
                          Navigator.pushNamed(context, '/init_questionnaire',
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
                              padding: const EdgeInsets.symmetric(
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
        body: SafeArea(
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Color.fromRGBO(212, 240, 255, 1),
                        Color.fromRGBO(177, 157, 255, 1)
                      ])),
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
