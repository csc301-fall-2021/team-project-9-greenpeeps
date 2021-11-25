import 'package:flutter/material.dart';
import 'package:green_peeps_app/questionnaire/questionnaire_category.dart';
import 'package:green_peeps_app/questionnaire/questionnaire_question.dart';
import 'package:green_peeps_app/models/question.dart';
import 'package:green_peeps_app/models/response.dart';
import 'package:provider/provider.dart';



// this manages the questionnaire category and questions popups.
// after choosing a category, we will add questions to the list,
// so that it will appear in the popup


class DailyQuestionsPopup extends StatefulWidget {
  const DailyQuestionsPopup({Key? key}) : super(key: key);

  @override
  _DailyQuestionsPopupState createState() => _DailyQuestionsPopupState();
}

class _DailyQuestionsPopupState extends State<DailyQuestionsPopup> {
  // Current index of which popup view to look at
  int _popupIndex = 0;
  String _currCategoryName = "";
  List<Question> questionList = [];
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);

  List<Question> _getQuestionList(){
    return [ Question(id: "q1", text: "Do you own a car?", fieldType: 1, type: 0,
        tags: ["Travel"], answers: [Answer(text:"Yes" ), Answer(text:"No" )]),
      Question(id: "q2", text: "What type of car do you have?",
          fieldType: 2, type: 2, tags: ["Travel"],
          answers: [Answer(text:"A good car" ), Answer(text:"A bad car" )]),
      Question(id: "q3", text: "How far do you drive everyday?",
          fieldType: 0, type: 1, tags: ["Travel"],
          answers: [Answer(text:"default" )])];
  }

  void _goBack(setState){
    setState(
      () {
        _popupIndex -= 1;
      })
    ;
  }

  // Changes popup view being viewed
  void _nextQuestion(setState, String categoryName) {
    setState(
          () {
        if (_popupIndex == 0) {
          _popupIndex = 1;
          _currCategoryName = categoryName;
          // pull from database list of questions
          questionList = _getQuestionList();

        } else {
          _popupIndex += 1;
          // get the next question in list
        }
      },
    );
  }

  List<String> getCategories(){
    // TODO pull categories from database
    return ["Food", "Electricity",
      "Water", "Transportation"];
    // TODO: categories should have a [completed] indicator?
  }
  
  _getQuestionWidgets( questionList){
    List<Widget> questionWidgets = [];
    for (Question question in questionList) {
      questionWidgets.add(DailyQuestionQuestion(question: question));
    }
    return questionWidgets;
  }

  final List<Widget> _popupViews = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (context) => QuestionListModel('F3Ct0WCqgIaAlkdrqE7X')),
            Provider(create: (context) => ResponseListModel())
          ],
      child: Consumer<QuestionListModel>(
            builder: (context, questionListModel, child) {
              // clear list in ase there are already questions in the list
              _popupViews.clear();
              // add category popup to list
              _popupViews.add(
                QuestionCategoryPopup(categories: getCategories(),
                setCategory: (String category){
                  _currCategoryName = category;
                  // setIndex to next question
                  _nextQuestion(setState, category);
                  }
                ));
              // add questions to list as widgets
              List<Widget> questionPopups = _getQuestionWidgets(questionListModel.questionList);
              _popupViews.addAll(questionPopups);
              return Dialog(
                  insetPadding: EdgeInsets.all(15),
                  backgroundColor: _boxColor,
                  child: SingleChildScrollView(
                    child: Container(
                      height: 600,
                      child: Column(
                        children: [
                          Container(
                            height: 10,
                          ),
                          AppBar(
                            elevation: 0,
                            toolbarHeight: 30,
                            backgroundColor: _boxColor,
                            automaticallyImplyLeading: false,
                            actions: <Widget>[

                              Visibility(
                                visible: _popupIndex > 0,
                                child: IconButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () {
                                    _goBack(setState); // Go back
                                  },
                                  icon: const Icon(Icons.arrow_back_rounded),
                                  color: Colors.black,
                                  splashRadius: 15,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.close_rounded),
                                color: Colors.black,
                                splashRadius: 15,
                              )
                            ],
                          ),
                          _popupViews.elementAt(_popupIndex)],
                      ),
                    ),
                  )
                  );
            }
            )
    );
  }
}

//
