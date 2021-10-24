import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'new_user_questionnaire/question.dart';
import 'new_user_questionnaire/response.dart';
import 'new_user_questionnaire/user_responses.dart';
import 'new_user_questionnaire/questionnaire_card.dart';


class InitialQuestionnaire extends StatefulWidget {
  const InitialQuestionnaire({Key? key}) : super(key: key);

  @override
  _InitialQuestionnaireState createState() => _InitialQuestionnaireState();
}

class _InitialQuestionnaireState extends State<InitialQuestionnaire> {
  @override
  String userID = "u1";
  late UserResponses userResponses;

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
  List<Response> responses = [];

  void _createResponses(){
    if(responses.isEmpty){
      userResponses = UserResponses(userID: userID);
      for (var question in questions) {
        responses.add(Response(userID: userID,
            qID: question.getId()));
      }
    }
  }


  void _saveResponses(){
    DateTime now = DateTime.now();
    print("Time to save!");
    for (var response in responses) {
      print('${response.qID}: ${[response.answer, response.timeStamp]}');
      if(response.answer != ""){
        response.timeStamp = now;
        // TODO: save response in database
        //  but for now we will save it in userResponses
          userResponses.addAnswer(response);
          print('saved ${response.qID}: ${[response.answer, response.timeStamp]}');
      }
    };
  }


  Widget build(BuildContext context) {
    _createResponses();
    int i = 0;
    return Scaffold(
      backgroundColor: Colors.black, // TODO gradient??
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _saveResponses();
            Navigator.popAndPushNamed(context, '/nav');
          },
          label: const Text("Save & Quit",
            style:  TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: "Nunito",
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  for(int i = 0 ; i < questions.length ; i++)
                      QuestionnaireCard(question: questions[i],
                       response: responses[i])
                  ]
                // questions.map((question) =>
                //     QuestionnaireCard(question: question,
                //     response: responses[])).toList(),
              )
        ),
      ),
    );
  }
}
