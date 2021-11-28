import 'package:flutter/material.dart';
import 'package:green_peeps_app/models/question.dart';
import 'package:green_peeps_app/questionnaire/build_question_form.dart';
import 'package:flutter/foundation.dart';

// rename to build question form

class QuestionnaireCard extends StatefulWidget {
  final Future<Question?> question;

  const QuestionnaireCard({Key? key, required this.question}) : super(key: key);

  @override
  _QuestionnaireCardState createState() => _QuestionnaireCardState();
}

class _QuestionnaireCardState extends State<QuestionnaireCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(248, 244, 219, 1),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: FutureBuilder<Question?>(
              future: widget.question,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError || !snapshot.hasData) {
                    return Text("Error loading data",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w700,
                        ));
                  } else {
                    return Text(snapshot.data.text,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w700,
                        ));
                  }
                } else {
                  return Text("Loading...",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w700,
                      ));
                }
              }),
        ),
        Column(
          children: [
            FutureBuilder<Question?>(
                future: widget.question,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      child: BuildQuestionForm(
                        question: snapshot.data!,
                      ),
                    );
                  } else {
                    return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        child: CircularProgressIndicator());
                  }
                })
          ],
        ),
      ]),
    );
  }
}
