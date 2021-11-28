import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_peeps_app/models/question.dart';
import 'package:green_peeps_app/models/response.dart';
import 'package:provider/provider.dart';

// build form credit skeleton: Grace

class BuildQuestionForm extends StatefulWidget {
  Question question;

  BuildQuestionForm({Key? key, required this.question}) : super(key: key);

  @override
  _BuildQuestionFormState createState() => _BuildQuestionFormState();
}

class _BuildQuestionFormState extends State<BuildQuestionForm> {
  @override
  double width = 175;

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

  Widget _buildDropDown(BuildContext context) {
    // String dropDownValue = widget.question.getAnswers()[0];

    return SizedBox(
      width: double.infinity,
      child: Consumer2<QuestionListModel, ResponseListModel>(
          builder: (context, questionListModel, responseListModel, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IgnorePointer(
                  ignoring: ignoreEnabled,
                  child: Container(
                    width: width,
                    child: DropdownButtonFormField<String>(
                      elevation: 8,
                      value: dropDownValue,
                      dropdownColor: Colors.white,
                      iconDisabledColor: Colors.grey,
                      iconEnabledColor: Colors.grey,
                      style: const TextStyle(color: Colors.black),
                      validator: (value) =>
                          value == null ? 'Please choose an option' : null,
                      onChanged: (newValue) {
                        setState(
                          () {
                            dropDownValue = newValue.toString();
                            // responseListModel.addResponse(Response(
                            // qID: widget.question.id, answer: dropDownValue!));
                            // // dropDownValue cannot be null because this is on changed
                            // for (Answer answer in widget.question.answers) {
                            //   if (answer.text == dropDownValue) {
                            //     if (answer.nextQuestion != null) {
                            //       questionListModel.addQuestion(answer.nextQuestion!);
                            //     }
                            //   break;
                            //   }
                            // }
                          },
                        );
                      },
                      // validator: (value) => value == null ? 'field required' : null,
                      items: widget.question
                          .getAnswerText()
                          .map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
                Visibility(
                  visible: ignoreEnabled,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                      size: 24.0,
                      semanticLabel:
                          "A checkmark to indicate that this question has been completed",
                    ),
                  ),
                ),
                Visibility(
                  visible: !ignoreEnabled,
                  child: TextButton.icon(
                      onPressed: () {
                        // check that dropdown value is not null
                        if (dropDownValue != null) {
                          setState(() {
                            responseListModel.addResponse(Response(
                                qID: widget.question.id,
                                answer: dropDownValue!));
                            // dropDownValue cannot be null because this is on changed
                            for (Answer answer in widget.question.answers) {
                              if (answer.text == dropDownValue) {
                                if (answer.nextQuestion != null) {
                                  questionListModel
                                      .addQuestion(answer.nextQuestion!);
                                }
                                break;
                              }
                            }
                            ignoreEnabled = true;
                            inputError = false;
                          });
                        } else {
                          setState(() {
                            inputError =
                                true; // if null tell user to choose an option
                          });
                        }
                      },
                      icon: Icon(Icons.check_circle_outline_rounded),
                      style: TextButton.styleFrom(
                        primary: Colors.green,
                      ),
                      label: Text("Confirm")),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4),
              child: Visibility(
                visible: inputError,
                child: Text("Please choose an option!",
                    style: TextStyle(color: Colors.grey, fontSize: 15)),
              ),
            ),
          ],
        );
      }),
    );
  }

  // Build a form widget for questions that require the user to input text
  // (will possibly need different validators for number answers and string answers)
  String input = "";
  Widget _buildNumberTextField(BuildContext context) {
    return SizedBox(
      width: double.infinity, // make 200 but then the box isnt on the left
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
          Consumer2<QuestionListModel, ResponseListModel>(
              builder: (context, questionListModel, responseListModel, thing) {
            return Row(
              children: [
                Container(
                  width: width ,
                  child: TextFormField(
                    enabled: !ignoreEnabled,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      // widget.response.answer = value;
                      return null;
                    },
                    onChanged: (value) {
                      setState(
                        () {
                          input = value;
                          // responseListModel.addResponse(
                          //     Response(qID: widget.question.id, answer: value));
                          // ignoreEnabled = true;
                          // for (Answer answer in widget.question.answers) {
                          //   if (answer.text == value) {
                          //     if (answer.nextQuestion != null) {
                          //       questionListModel.addQuestion(answer.nextQuestion!);
                          //
                          //     }
                          //     break;
                          //   }
                          // }
                        },
                      );
                    },
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      hintText: 'Please enter a number',
                    ),
                  ),
                ),
                Visibility(
                  visible: ignoreEnabled,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                      size: 24.0,
                      semanticLabel:
                          "A checkmark to indicate that this question has been completed",
                    ),
                  ),
                ),
                Visibility(
                  visible: !ignoreEnabled,
                  child: TextButton.icon(
                      onPressed: () {
                        // check that input value is not empty
                        if (input.isNotEmpty) {
                          setState(() {
                            responseListModel.addResponse(Response(
                                qID: widget.question.id, answer: input));
                            // dropDownValue cannot be null because this is on changed
                            for (Answer answer in widget.question.answers) {
                              if (answer.text == dropDownValue) {
                                if (answer.nextQuestion != null) {
                                  questionListModel
                                      .addQuestion(answer.nextQuestion!);
                                }
                                break;
                              }
                            }
                            ignoreEnabled = true;
                            inputError = false;
                          });
                        } else {
                          setState(() {
                            inputError =
                                true; // if null tell user to choose an option
                          });
                        }
                      },
                      icon: Icon(Icons.check_circle_outline_rounded),
                      style: TextButton.styleFrom(
                        primary: Colors.green,
                      ),
                      label: Text("Confirm")),
                ),
              ],
            );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4),
            child: Visibility(
              visible: inputError,
              child: Text("Please enter a value!",
                  style: TextStyle(color: Colors.grey, fontSize: 15)),
            ),
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

  String? dropDownValue = null;
  void _setDefaultDropDownValue() {
    if (dropDownValue == "") {
      dropDownValue = widget.question.getAnswerText()[0];
    }

    // if(dropDownItems == []){
    //   dropDownItems.addAll(widget.question.getAnswerText());
    // }
  }

  bool ignoreEnabled = false;
  bool inputError = false;
  Widget build(BuildContext context) {
    if (widget.question.fieldType == 0) {
      // Numerical
      return _buildNumberTextField(context);
    } else if (widget.question.fieldType == 1) {
      // Multiple choice [ACTUALLY REPLACE W DROPDOWN]
      _setDefaultDropDownValue();
      return _buildDropDown(context);
    } else if (widget.question.fieldType == 2) {
      // Dropdown
      _setDefaultDropDownValue();
      return _buildDropDown(context);
    } else {
      return const SizedBox(
          child: Text("Error: There is no form for this question"));
    }
  }
}
