import 'package:flutter/material.dart';
import 'package:green_peeps_app/questionnaire/build_question_form.dart';

typedef CategoryCallback = void Function(String category);

class QuestionCategoryPopup extends StatefulWidget {
  final CategoryCallback setCategory;
  final List<String> categories;
  final bool noMoreQuestions;
  const QuestionCategoryPopup({Key? key,
    required this.categories,
    required this.noMoreQuestions,
    required this.setCategory}) : super(key: key);

  @override
  _QuestionCategoryPopupState createState() => _QuestionCategoryPopupState();
}

class _QuestionCategoryPopupState extends State<QuestionCategoryPopup> {
  // Box Variables
  final double _boxPadding = 10.0;
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);

  Widget _makeCategoryButton(BuildContext context, String categoryName) {
    return TextButton(
      onPressed: () {
        widget.setCategory(categoryName);
      },
      child: Text(categoryName),
      style: TextButton.styleFrom(
        primary: Colors.black,
        backgroundColor: const Color.fromRGBO(201, 221, 148, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _boxPadding + 5, vertical: _boxPadding),
      width: double.infinity,

      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Visibility(
            visible: widget.noMoreQuestions,
            child: Container(
              child: const Text("There are no more questions available for this category, "
                  "Please choose a new one",
                style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),),
            ),
          // Text(
          //   "You are " +
          //       progressLeft.toString() +
          //       " points away from your next leaf!",
          //   style: const TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.black),
          // ),
          // Divider(color: _boxColor),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(10),
          //   child: LinearProgressIndicator(
          //     backgroundColor: const Color.fromRGBO(180, 180, 180, 1),
          //     valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
          //     value: progressCompleted,
          //     minHeight: 10,
          //   ),
          // ),
          Divider(color: _boxColor),
          const Text(
            "Receive 1 point per Question!",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          Divider(color: _boxColor),
          const Text(
            "Categories",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          // If the number of categories exceed the box, it becomes scrollable
          SingleChildScrollView(
            // If the number of categories per row overflow, it will start at a new row
            child: Wrap(
              spacing: 8,
              children: <Widget>[
                for (var category in widget.categories)
                  _makeCategoryButton(context, category)
              ],
            ),
          ),
        ],
      ),
    );
  }
}


