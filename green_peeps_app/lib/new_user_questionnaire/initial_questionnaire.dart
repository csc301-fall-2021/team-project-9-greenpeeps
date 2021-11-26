import 'package:flutter/material.dart';
import 'package:green_peeps_app/models/question.dart';
import 'package:green_peeps_app/models/response.dart';
import 'package:provider/provider.dart';
import 'package:green_peeps_app/questionnaire/questionnaire_card.dart';
import 'package:green_peeps_app/new_user_questionnaire/initial_questionnaire_info_card.dart';


class InitialQuestionnaire extends StatefulWidget {
  const InitialQuestionnaire({Key? key}) : super(key: key);

  @override
  _InitialQuestionnaireState createState() => _InitialQuestionnaireState();
}

class _InitialQuestionnaireState extends State<InitialQuestionnaire> {
  @override
  String userID = "u1";
  ScrollController _controller = ScrollController();

  void _ScrollDown(){
    if(_controller.hasClients){
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 100),
        curve: Curves.ease,
      );
      print("Scroll!!!");
      print( _controller.position.maxScrollExtent);
    };
  }

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // this does not work rn :/ TODO
    _ScrollDown();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => QuestionListModel('F3Ct0WCqgIaAlkdrqE7X')),
          Provider(create: (context) => ResponseListModel())
        ],
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
              // color: Colors.purple,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.purple])),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Consumer<ResponseListModel>(
                  builder: (context, responseListModel, child) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                      // fit: StackFit.expand,
                      children: [
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
                              fontSize: 20,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          backgroundColor: Colors.green,
                          ),
                        Spacer(),
                        FloatingActionButton.extended(
                          onPressed: () {
                          responseListModel.saveResponsesToStore();
                          Navigator.popAndPushNamed(context, '/nav');
                          },
                          heroTag: null,
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
                          )
                      ],
                    ),
                );
                }
                  ),

              body: SingleChildScrollView(
                  child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.purple])),
                child: Consumer<QuestionListModel>(
                    builder: (context, questionListModel, child) {
                  return SingleChildScrollView(
                    child: Column(children: [
                      InitialQuestionnaireInfoCard(),
                      ListView.builder(
                        controller: _controller,
                        itemCount: questionListModel.questionList.length + 1,
                        shrinkWrap: true,
                        itemBuilder: (context, index){
                          if (index == questionListModel.questionList.length) {
                            return Container(
                              height: 90,
                              // child: Card(child:Text("HI!!!"))
                            );
                          }
                          return QuestionnaireCard(question: questionListModel
                                .questionList[index]);
                        },
                      ),
                      // for (Question question in questionListModel.questionList)
                      //   QuestionnaireCard(question: question),
                      // SizedBox(height: 90)
                    ]),
                  );
                }),
              )),
            ),
          ),
        ));
  }
}
