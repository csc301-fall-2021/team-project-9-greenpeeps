import 'package:flutter/material.dart';
import 'package:green_peeps_app/questionnaire/questionnaire_category.dart';
import 'package:green_peeps_app/questionnaire/questionnaire_question.dart';
import 'package:green_peeps_app/models/question.dart';
import 'package:green_peeps_app/models/response.dart';
import 'package:green_peeps_app/homescreen/completed_daily_questions.dart';
import 'package:green_peeps_app/services/question_firestore.dart';
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
  bool _noMoreQuestions = false;

  int _questionsDone = 0;
  final int _questionsTodo = 2;

// tODO would it actually make more sense for this to just go back to the
  // category page rather than last question? or go back a page?
  void _goBack(setState) {
    setState(() {
      _popupIndex = 0;
    });
  }

  // Callback for skipping questions
  void _nextQuestion(setState, String categoryName) {
    setState(
      () {
        if (_popupIndex == 0) {
          _popupIndex = 1;
          _currCategoryName = categoryName;
        } else if (_popupIndex < _popupViews.length - 1) {
          _popupIndex += 1;
          // get the next question in list
        } else {
          // no more questions! try another category
          _popupIndex = 0;
          _noMoreQuestions = true;
        }
      },
    );
  }

  Future<List<String>?> getCategories() async {
    QuestionMetadata? metadata = await getMetadata();
    return metadata?.categories.keys.toList();
  }

  Widget _getCategoryPage() {
    return QuestionCategoryPopup(
        categories: getCategories(),
        setCategory: (String category) {
          _currCategoryName = category;
          _noMoreQuestions = false;
          _nextQuestion(setState, category);
        },
        noMoreQuestions: _noMoreQuestions);
  }

  Widget _getCompletionPage() {
    return CompletedDailyQuestions(quit: () {
      Navigator.of(context).pop();
    }, answerMore: () {
      _questionsDone += 1;
      setState(() {
        _popupViews.clear();
        _popupIndex = 0;
      });
    });
  }

  Widget _getQuestionWidgets(questionList) {
    List<Widget> questionWidgets = [];
    for (Future<Question?> question in questionList) {
      questionWidgets.add(Consumer<ResponseListModel>(
          builder: (context, responseListModel, child) {
        return DailyQuestionQuestion(
            question: question,
            skipQuestion: () {
              setState(() {
                _nextQuestion(setState, _currCategoryName);
              });
            },
            saveQuestion: () {
              setState(() {
                _questionsDone += 1;
                responseListModel.saveResponsesToStore();
                _nextQuestion(setState, _currCategoryName);
              });
            });
      }));
    }
    return questionWidgets[0];
  }

  final List<Widget> _popupViews = <Widget>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                Container(height: 5),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      backgroundColor: const Color.fromRGBO(180, 180, 180, 1),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.blue),
                      value: (_questionsDone / _questionsTodo),
                      minHeight: 15,
                    ),
                  ),
                ),
                // TODO: Insert view here
              ],
            ),
          ),
        ));
  }
}
