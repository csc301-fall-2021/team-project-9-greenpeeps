import 'package:flutter/material.dart';
import 'package:green_peeps_app/models/question.dart';
import 'package:green_peeps_app/models/response.dart';
import 'package:provider/provider.dart';
import 'package:green_peeps_app/questionnaire/questionnaire_card.dart';

class InitialQuestionnaire extends StatefulWidget {
  final List<String> remainingQuestions;

  const InitialQuestionnaire({Key? key, required this.remainingQuestions})
      : super(key: key);

  @override
  _InitialQuestionnaireState createState() => _InitialQuestionnaireState();
}

class _InitialQuestionnaireState extends State<InitialQuestionnaire> {
  String rootQuestion = "";

  @override
  void initState() {
    super.initState();
    rootQuestion = widget.remainingQuestions.removeLast();
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
          backgroundColor: Colors.transparent,
          floatingActionButton: Consumer<ResponseListModel>(
              builder: (context, responseListModel, child) {
            if (widget.remainingQuestions.isEmpty) {
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
            } else {
              return FloatingActionButton.extended(
                onPressed: () {
                  responseListModel.saveResponsesToStore();
                  Navigator.popAndPushNamed(context, '/init_questionnaire',
                      arguments: widget.remainingQuestions);
                },
                label: const Text(
                  "Save & Continue",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                backgroundColor: Colors.green,
              );
            }
          }),
          body: CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.purple])),
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
