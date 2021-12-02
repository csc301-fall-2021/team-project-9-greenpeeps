import 'package:flutter/material.dart';
import 'package:green_peeps_app/new_user_questionnaire/initial_questionnaire_info_card.dart';

class InitialQuestionnaireIntro extends StatelessWidget {
  const InitialQuestionnaireIntro({Key? key}) : super(key: key);
// Color.fromRGBO(157, 207, 148, 1), bg
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(157, 207, 148, 1),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InitialQuestionnaireInfoCard(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: ElevatedButton(
                    onPressed:() async {
                      Navigator.pushNamed(context, '/init_questionnaire');
                      },
                    child: Text("Continue",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    // maximumSize: const Size(150, 75),
                    minimumSize: const Size(double.infinity, 75),
                  ),
                ),
              )
            ],
          ),
        )
      );
  }
}


    
    
