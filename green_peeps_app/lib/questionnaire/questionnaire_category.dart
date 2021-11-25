import 'package:flutter/material.dart';
import 'package:green_peeps_app/questionnaire/build_question_form.dart';

typedef CategoryCallback = void Function(String category);

class QuestionCategoryPopup extends StatefulWidget {
  final CategoryCallback setCategory;
  final List<String> categories;
  const QuestionCategoryPopup({Key? key,
    required this.categories,
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
        // pull questions from database
        // open question dialog
        //
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
    return Dialog(
      backgroundColor: _boxColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(_boxPadding + 5),
        width: double.infinity,
        height: 535,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppBar(
              elevation: 0,
              toolbarHeight: 30,
              backgroundColor: _boxColor,
              automaticallyImplyLeading: false, // No back arrow
              actions: <Widget>[
                IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.of(context).pop(); // Closes popup
                  },
                  icon: const Icon(Icons.close),
                  color: Colors.black,
                  splashRadius: 15,
                )
              ],
            ),
            // Text( TODO progress bar
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
      ),
    );
  }
}



// class QuestionPopup extends StatefulWidget {
//   const QuestionPopup({Key? key}) : super(key: key);
//
//   @override
//   _QuestionPopup createState() => _QuestionPopup();
// }
//
// class _QuestionPopup extends State<QuestionPopup> {
//   // Current index of which popup view to look at
//   int _popupIndex = 0;
//
//   // Name of the category button that was pressed on from the first popup view
//   String _currCategoryName = "";
//
//   // Box Variables
//   final double _boxPadding = 10.0;
//   final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);
//
//   // Database Information
//   String dropDownValue = 'Bus';
//   double _progressCompleted = 0.5; // Must be from 0 to 1
//   int _progressLeft = 50; // Represented in amount of points
//
//   // User's carbon emmissions breakdown from database
//   final Map<String, double> _pieChartCategories = {
//     "Food": 5,
//     "Electricity": 3,
//     "Water": 2,
//     "Transportation": 2,
//     ":)": 2,
//     ":(": 30,
//     ":/": 10,
//     ":O": 4
//   };
//
//   // Changes popup view being viewed
//   void _setIndex(setState, String categoryName) {
//     setState(
//           () {
//         if (_popupIndex == 0) {
//           _popupIndex = 1;
//           _currCategoryName = categoryName;
//         } else {
//           _popupIndex = 0;
//         }
//       },
//     );
//   }
//
//   // Updates progress bar and points when a user submits
//   void _setProgressBar(setState, double newProgressCompleted) {
//     setState(
//           () {
//         _progressCompleted = newProgressCompleted;
//         _progressLeft = _progressLeft - 1;
//       },
//     );
//   }
//
//   // Consider making its own file
//   // (use case?)
//   Widget _makeCategoryButton(BuildContext context, String categoryName) {
//     return TextButton(
//       onPressed: () {
//         _setIndex(setState, categoryName);
//       },
//       child: Text(categoryName),
//       style: TextButton.styleFrom(
//         primary: Colors.black,
//         backgroundColor: const Color.fromRGBO(201, 221, 148, 1),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//       ),
//     );
//   }
//
//   // Build a form widget for questions with yes/no answer
//   Widget _buildOption(BuildContext context) {
//     return SizedBox(
//       width: double.infinity, // this value is the maximum value width can be
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: const <Widget>[
//           Text("TBD"),
//         ],
//       ),
//     );
//   }
//
//   // Build a form widget for questions with answers selected from dropdown box
//   Widget _buildDropDown(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           const Text(
//             "How'd you get to work today?",
//             style: TextStyle(
//                 fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//           ),
//           const Divider(),
//           DropdownButton<String>(
//             elevation: 8,
//             value: dropDownValue,
//             dropdownColor: Colors.white,
//             iconDisabledColor: Colors.grey,
//             iconEnabledColor: Colors.grey,
//             style: const TextStyle(color: Colors.black),
//             onChanged: (newValue) {
//               setState(
//                     () {
//                   dropDownValue = newValue.toString();
//                 },
//               );
//             },
//             items: <String>['Car', 'Bus', 'Bike', 'Walked']
//                 .map<DropdownMenuItem<String>>(
//                   (String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               },
//             ).toList(),
//           ),
//           const Divider(),
//         ],
//       ),
//     );
//   }
//
//   // Build a form widget for questions that require the user to input text
//   // (will possibly need different validators for number answers and string answers)
//   Widget _buildTextField(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           const Text(
//             "How long did it take to get to work today?",
//             style: TextStyle(
//                 fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//           ),
//           TextFormField(
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter some text';
//               }
//               return null;
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Builds a widget appropriate to type of question
//   // (ideally this will be used in a for loop for link list of category questions)
//   Widget _buildForm(BuildContext context, String type) {
//     if (type == "Option") {
//       return _buildOption(context);
//     } else if (type == "DropDown") {
//       return _buildDropDown(context);
//     } else if (type == "TextField") {
//       return _buildTextField(context);
//     } else {
//       return const SizedBox();
//     }
//   }
//
//   // The first view of the popups
//   Widget _buildCategoryPopup(BuildContext context, double boxPadding,
//       double progressCompleted, int progressLeft, Color boxColor) {
//     return Dialog(
//       backgroundColor: boxColor,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(5.0),
//         ),
//       ),
//       child: Container(
//         padding: EdgeInsets.all(boxPadding + 5),
//         width: double.infinity,
//         height: 535,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             AppBar(
//               elevation: 0,
//               toolbarHeight: 30,
//               backgroundColor: boxColor,
//               automaticallyImplyLeading: false, // No back arrow
//               actions: <Widget>[
//                 IconButton(
//                   padding: const EdgeInsets.all(0),
//                   onPressed: () {
//                     Navigator.of(context).pop(); // Closes popup
//                   },
//                   icon: const Icon(Icons.close),
//                   color: Colors.black,
//                   splashRadius: 15,
//                 )
//               ],
//             ),
//             Text(
//               "You are " +
//                   progressLeft.toString() +
//                   " points away from your next leaf!",
//               style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black),
//             ),
//             Divider(color: boxColor),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: LinearProgressIndicator(
//                 backgroundColor: const Color.fromRGBO(180, 180, 180, 1),
//                 valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
//                 value: progressCompleted,
//                 minHeight: 10,
//               ),
//             ),
//             Divider(color: boxColor),
//             const Text(
//               "Receive 1 point per Question!",
//               style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black),
//             ),
//             Divider(color: boxColor),
//             const Text(
//               "Categories",
//               style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black),
//             ),
//             // If the number of categories exceed the box, it becomes scrollable
//             SingleChildScrollView(
//               // If the number of categories per row overflow, it will start at a new row
//               child: Wrap(
//                 spacing: 8,
//                 children: <Widget>[
//                   for (var key in _pieChartCategories.keys)
//                     _makeCategoryButton(context, key)
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // The second view of the popups
//   Widget _buildQuestionPopupTwo(BuildContext context, double boxPadding,
//       double progressCompleted, int progressLeft, Color boxColor) {
//     return Dialog(
//       backgroundColor: boxColor,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(5.0),
//         ),
//       ),
//       child: Container(
//         padding: EdgeInsets.all(boxPadding + 5),
//         width: double.infinity,
//         height: 535,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             AppBar(
//               elevation: 0,
//               toolbarHeight: 30,
//               backgroundColor: boxColor,
//               automaticallyImplyLeading: false,
//               actions: <Widget>[
//                 IconButton(
//                   padding: const EdgeInsets.all(0),
//                   onPressed: () {
//                     _setIndex(setState, ""); // Go back
//                   },
//                   icon: const Icon(Icons.arrow_back_rounded),
//                   color: Colors.black,
//                   splashRadius: 15,
//                 ),
//                 const Spacer(),
//                 IconButton(
//                   padding: const EdgeInsets.all(0),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   icon: const Icon(Icons.close_rounded),
//                   color: Colors.black,
//                   splashRadius: 15,
//                 )
//               ],
//             ),
//             Divider(color: boxColor),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: LinearProgressIndicator(
//                 backgroundColor: const Color.fromRGBO(180, 180, 180, 1),
//                 valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
//                 value: progressCompleted,
//                 minHeight: 10,
//               ),
//             ),
//             Divider(color: boxColor),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(15),
//               child: Container(
//                 padding: const EdgeInsets.only(
//                     top: 5, bottom: 5, left: 15, right: 15),
//                 color: const Color.fromRGBO(201, 221, 148, 1),
//                 child: Text(
//                   _currCategoryName,
//                   style: const TextStyle(fontSize: 20, color: Colors.black),
//                 ),
//               ),
//             ),
//             Divider(color: boxColor),
//             _buildForm(context, "DropDown"),
//             Divider(color: boxColor),
//             _buildForm(context, "TextField"),
//             Divider(color: boxColor),
//             Row(
//               children: <Widget>[
//                 const Spacer(),
//                 TextButton(
//                   child: const Text('Submit'),
//                   onPressed: () {
//                     _setProgressBar(setState, 0.8);
//                   },
//                   style: TextButton.styleFrom(
//                     primary: Colors.white,
//                     backgroundColor: const Color.fromRGBO(2, 152, 89, 1),
//                     elevation: 5,
//                     fixedSize: const Size(146, 42),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> _popupViews = <Widget>[
//       _buildCategoryPopup(
//           context, _boxPadding, _progressCompleted, _progressLeft, _boxColor),
//       _buildQuestionPopupTwo(
//           context, _boxPadding, _progressCompleted, _progressLeft, _boxColor),
//     ];
//     return SingleChildScrollView(
//       child: _popupViews.elementAt(_popupIndex),
//     );
//   }
// }
