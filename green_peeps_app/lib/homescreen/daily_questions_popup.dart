import 'package:flutter/material.dart';
import 'package:green_peeps_app/questionnaire/questionnaire_category.dart';
import 'package:green_peeps_app/questionnaire/questionnaire_question.dart';

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

  // Changes popup view being viewed
  void _setIndex(setState, String categoryName) {
    setState(
          () {
        if (_popupIndex == 0) {
          _popupIndex = 1;
          _currCategoryName = categoryName;
        } else {
          _popupIndex = 0;
        }
      },
    );
  }

  getCategories(){
    // TODO pull categories from database
    return ["Food", "Electricity",
      "Water", "Transportation"];
    // TODO: categories should have a [completed] indicator?
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _popupViews = <Widget>[
      QuestionCategoryPopup(categories: getCategories(),
          setCategory: (String category){
        _currCategoryName = category;
        // pull questions from category
        // setIndex to next question
        }
      )
      // _buildCategoryPopup(
      //     context, _boxPadding, _progressCompleted, _progressLeft, _boxColor),
      // _buildQuestionPopupTwo(
      //     context, _boxPadding, _progressCompleted, _progressLeft, _boxColor),
    ];
    return SingleChildScrollView(
      child: _popupViews.elementAt(_popupIndex),
    );
  }
}


