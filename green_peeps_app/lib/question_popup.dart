import 'package:flutter/material.dart';

class QuestionPopup extends StatefulWidget {
  const QuestionPopup({Key? key}) : super(key: key);

  @override
  _QuestionPopup createState() => _QuestionPopup();
}

class _QuestionPopup extends State<QuestionPopup> {
  int _selectedIndex = 0;
  String _currCategoryName = "";

  // Box Variables
  final double _boxPadding = 10.0;
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);
  String dropDownValue = 'Bus';

  // Database Information
  double _progressCompleted = 0.5; // Must be from 0 to 1
  int _progressLeft = 50; // Represented in amount of points

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

  void _setIndex(setState, String categoryName) {
    setState(
      () {
        if (_selectedIndex == 0) {
          _selectedIndex = 1;
          _currCategoryName = categoryName;
        } else {
          _selectedIndex = 0;
        }
      },
    );
  }

  void _setProgressBar(setState, double newProgressCompleted) {
    setState(
      () {
        _progressCompleted = newProgressCompleted;
        _progressLeft = _progressLeft - 1;
      },
    );
  }

  // Consider making its own file
  Widget _makeCategoryButton(BuildContext context, String categoryName) {
    return TextButton(
      onPressed: () {
        _setIndex(setState, categoryName);
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

  Widget _buildOption(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text("TBD"),
        ],
      ),
    );
  }

  Widget _buildDropDown(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "How'd you get to work today?",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const Divider(),
          DropdownButton<String>(
            value: dropDownValue,
            dropdownColor: Colors.white,
            iconDisabledColor: Colors.grey,
            iconEnabledColor: Colors.grey,
            elevation: 8,
            style: const TextStyle(color: Colors.black),
            onChanged: (newValue) {
              setState(() {
                dropDownValue = newValue.toString();
              });
            },
            items: <String>['Car', 'Bus', 'Bike', 'Walked']
                .map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildTextField(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "How long did it take to get to work today?",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context, String type) {
    if (type == "Option") {
      return _buildOption(context);
    } else if (type == "DropDown") {
      return _buildDropDown(context);
    } else if (type == "TextField") {
      return _buildTextField(context);
    } else {
      return const SizedBox();
    }
  }

  Widget _buildQuestionPopupOne(BuildContext context, double boxPadding,
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

  Widget _buildQuestionPopupTwo(BuildContext context, double boxPadding,
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
                      _setIndex(setState, "");
                    },
                    icon: const Icon(Icons.arrow_back_rounded),
                    color: Colors.black),
                const Spacer(),
                IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close_rounded),
                    color: Colors.black)
              ],
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
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 15, right: 15),
                color: const Color.fromRGBO(201, 221, 148, 1),
                child: Text(
                  _currCategoryName,
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            Divider(color: boxColor),
            _buildForm(context, "DropDown"),
            Divider(color: boxColor),
            _buildForm(context, "TextField"),
            Divider(color: boxColor),
            Row(
              children: <Widget>[
                const Spacer(),
                TextButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    _setProgressBar(setState, 0.8);
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: const Color.fromRGBO(2, 152, 89, 1),
                    elevation: 5,
                    fixedSize: const Size(146, 42),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      _buildQuestionPopupOne(
          context, _boxPadding, _progressCompleted, _progressLeft, _boxColor),
      _buildQuestionPopupTwo(
          context, _boxPadding, _progressCompleted, _progressLeft, _boxColor),
    ];
    return SingleChildScrollView(
      child: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
