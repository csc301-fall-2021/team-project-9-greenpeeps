import 'package:flutter/material.dart';

class InitialQuestionnaireInfoCard extends StatelessWidget {
  const InitialQuestionnaireInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(248, 244, 219, 1),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Text("The best way to get to know each other is to... get to know each other! "
              "We'd like to ask you some initial questions about your lifestyle and habits to help us to curate helpful information and tips for you to adopt some new green habits. "
              "There's no need to do these all at once, so when you feel finished with the questions, you can hit the exit button and come back anytime. "
              "All the info we learn about you we populate into your profile, but we never use your information for anything other than tailoring your experience using this app. ",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: "Nunito",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ]
    ),
    );
  }
}



