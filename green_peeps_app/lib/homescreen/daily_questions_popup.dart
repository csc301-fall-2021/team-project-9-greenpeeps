import 'dart:math';

import 'package:flutter/material.dart';
import 'package:green_peeps_app/questionnaire/questionnaire_category.dart';
import 'package:green_peeps_app/questionnaire/questionnaire_question.dart';
import 'package:green_peeps_app/models/question.dart';
import 'package:green_peeps_app/homescreen/completed_daily_questions.dart';
import 'package:green_peeps_app/services/question_firestore.dart';
import 'package:green_peeps_app/services/response_firestore.dart';
import 'package:green_peeps_app/services/userdata_firestore.dart';

// this manages the questionnaire category and questions popups.
// after choosing a category, we will add questions to the list,
// so that it will appear in the popup

class DailyQuestionsPopup extends StatefulWidget {
  const DailyQuestionsPopup({Key? key}) : super(key: key);

  @override
  _DailyQuestionsPopupState createState() => _DailyQuestionsPopupState();
}

class _DailyQuestionsPopupState extends State<DailyQuestionsPopup> {
  Future<String?>? _question;
  String _currCategoryName = "";
  List<String> _questionList = [];
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);
  bool _noMoreQuestions = false;

  int _questionsDone = 0;
  final int _questionsTodo = 2;

  void _goBack(setState) {
    setState(() {
      _question = null;
    });
  }

  Widget getPopup() {
    if (_questionsDone == _questionsTodo) {
      return _getCompletionPage();
    } else {
      if (_question == null) {
        return _getCategoryPage();
      } else {
        return _getQuestionPage();
      }
    }
  }

  Future<List<String>?> getCategoryNames() async {
    QuestionMetadata? metadata = await getMetadata();
    return metadata?.categories.keys.toList();
  }

  Future<String?> _getQuestionId() async {
    if (_questionList.isEmpty) {
      QuestionMetadata? metadata = await getMetadata();
      List<String>? categoryQuestions =
          metadata?.categories[_currCategoryName.toLowerCase()];
      if (categoryQuestions == null) {
        return null;
      }
      List<String> completedQuestions =
          (await getResponses())?.map((response) => response.qID).toList() ??
              [];
      List<String> skippedQuestions = await getSkippedQuestions() ?? [];

      _questionList = categoryQuestions
          .toSet()
          .difference(completedQuestions.toSet())
          .difference(skippedQuestions.toSet())
          .toList();
    }
    if (_questionList.isEmpty) {
      return null;
    } else {
      return _questionList.removeAt((Random().nextInt(_questionList.length)));
    }
  }

  Widget _getCategoryPage() {
    return QuestionCategoryPopup(
        categories: getCategoryNames(),
        setCategory: (String category) {
          setState(() {
            _currCategoryName = category;
            _questionList = [];
            _noMoreQuestions = false;
            _question = _getQuestionId();
          });
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
      });
    });
  }

  Widget _getQuestionPage() {
    Future<String?> questionId = _getQuestionId();
    return FutureBuilder<String?>(
        future: questionId,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return DailyQuestionQuestion(
                  question: snapshot.data!,
                  nextQuestion: (bool skip) {
                    setState(() {
                      _question = _getQuestionId();
                      if (!skip) {
                        _questionsDone += 1;
                      }
                    });
                  });
            } else {
              _noMoreQuestions = true;
              return _getCategoryPage();
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
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
                      visible: false,
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
                getPopup()
              ],
            ),
          ),
        ));
  }
}
