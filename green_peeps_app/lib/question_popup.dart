import 'package:flutter/material.dart';

class QuestionPopup extends StatefulWidget {
  const QuestionPopup({Key? key}) : super(key: key);

  @override
  _QuestionPopup createState() => _QuestionPopup();
}

class _QuestionPopup extends State<QuestionPopup> {
  int _selectedIndex = 0;

  // Box Variables
  final double _boxPadding = 10.0;
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);

  // Database Information
  final double _progressCompleted = 0.5; // Must be from 0 to 1
  final int _progressLeft = 50; // Represented in amount of points

  // User's carbon emmissions breakdown from database
  final Map<String, double> _pieChartCategories = {
    "Food": 5,
    "Electricity": 3,
    "Water": 2,
    "Transportation": 2,
    ":)": 2,
    ":(": 30,
    ":/": 10,
    ":O": 4
  };

  void _setIndex(setState) {
    setState(
      () {
        _selectedIndex = 1;
      },
    );
  }

  // Consider making its own file
  Widget _makeCategoryButton(BuildContext context, String categoryName) {
    return TextButton(
      onPressed: () {
        _setIndex(setState);
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

  Widget _buildQuestionPopup(BuildContext context, double boxPadding,
      double progressCompleted, int progressLeft, Color boxColor) {
    return Dialog(
      backgroundColor: boxColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(boxPadding + 5),
        width: double.infinity,
        height: 535,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppBar(
              backgroundColor: boxColor,
              elevation: 0,
              toolbarHeight: 30,
              automaticallyImplyLeading: false,
              actions: <Widget>[
                IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                    color: Colors.black)
              ],
            ),
            Text(
              "You are " +
                  progressLeft.toString() +
                  " points away from your next leaf!",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Divider(color: boxColor),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                backgroundColor: const Color.fromRGBO(180, 180, 180, 1),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                value: progressCompleted,
                minHeight: 10,
              ),
            ),
            Divider(color: boxColor),
            const Text(
              "Receive 1 point per Question!",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Divider(color: boxColor),
            const Text(
              "Categories",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SingleChildScrollView(
              child: Wrap(
                spacing: 8,
                children: <Widget>[
                  for (var key in _pieChartCategories.keys)
                    _makeCategoryButton(context, key)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      _buildQuestionPopup(
          context, _boxPadding, _progressCompleted, _progressLeft, _boxColor),
      _buildQuestionPopup(
          context, _boxPadding, _progressCompleted, _progressLeft, Colors.teal),
    ];
    return _widgetOptions.elementAt(_selectedIndex);
  }
}
