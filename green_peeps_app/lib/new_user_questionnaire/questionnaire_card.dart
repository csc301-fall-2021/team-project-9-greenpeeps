import 'package:flutter/material.dart';
import 'package:green_peeps_app/new_user_questionnaire/question.dart';

class QuestionnaireCard extends StatefulWidget {
  final Question question;

  const QuestionnaireCard({Key? key, required this.question}) : super(key: key);

  @override
  _QuestionnaireCardState createState() => _QuestionnaireCardState();
}

class _QuestionnaireCardState extends State<QuestionnaireCard> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}