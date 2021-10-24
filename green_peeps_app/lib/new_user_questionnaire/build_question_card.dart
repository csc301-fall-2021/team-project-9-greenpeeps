import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_peeps_app/new_user_questionnaire/question.dart';

// build form credit skeleton: Grace


class BuildQuestionForm extends StatefulWidget {
  Question question;
  String answer;

  BuildQuestionForm({Key? key, required this.question,
    required this.answer}) : super(key: key);



  @override
  _BuildQuestionFormState createState() => _BuildQuestionFormState();
}

class _BuildQuestionFormState extends State<BuildQuestionForm> {
  @override
  // static String dropDownValue = widget.question.getAnswers()[0];
  // TODO make radio button question type

  Widget _makeMCButton(BuildContext context, String categoryName) {
    return TextButton(
      onPressed: () {
        // TODO set value of mc and return??? /create response
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

  // Build a form widget for questions with yes/no answer
  // Widget _buildOption(BuildContext context) {
  //   return SizedBox(
  //     width: double.infinity, // this value is the maximum value width can be
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: const <Widget>[
  //         Text("TBD"),
  //       ],
  //     ),
  //   );
  // }

  // Build a form widget for questions with answers selected from dropdown box

  Widget _buildDropDown(BuildContext context, setState) {
    // String dropDownValue = widget.question.getAnswers()[0];
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DropdownButton<String>(
            elevation: 8,
            value: dropDownValue,
            dropdownColor: Colors.white,
            iconDisabledColor: Colors.grey,
            iconEnabledColor: Colors.grey,
            style: const TextStyle(color: Colors.black),
            onChanged: (newValue) {
              setState(() {
                  dropDownValue = newValue.toString();
                  widget.answer = dropDownValue;
                },

              );
            },
            items: widget.question.getAnswers()
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

  // Build a form widget for questions that require the user to input text
  // (will possibly need different validators for number answers and string answers)
  Widget _buildNumberTextField(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text("Please enter a number:",
          //   style: TextStyle(
          //       fontSize: 15,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.grey),
          // ),
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              widget.answer = value;
              return null;
            },
            onChanged: (value) {
              setState(() {
                widget.answer = value;
              },);
            },
            decoration: InputDecoration(
              hintText: 'Please enter a number',
            ),
          ),
        ],
      ),
    );
  }

  String dropDownValue = "";
  void _setDefaultDropDownValue(){
    if (dropDownValue == ""){
      dropDownValue = widget.question.getAnswers()[0];
    }
  }


  Widget build(BuildContext context) {
    _setDefaultDropDownValue();
    if (widget.question.fieldType == 0) { // Numerical
      return _buildNumberTextField(context);
    } else if (widget.question.fieldType == 1) { // Multiple choice [ACTUALLY REPLACE W DROPDOWN]
      return _buildDropDown(context, setState);
    } else if (widget.question.fieldType == 2) { // Dropdown
      return _buildDropDown(context, setState);
    } else {
      return const SizedBox();
    }
  }
}


