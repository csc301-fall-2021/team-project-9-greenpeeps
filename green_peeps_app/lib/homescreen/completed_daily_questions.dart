import 'package:flutter/material.dart';

class CompletedDailyQuestions extends StatefulWidget {
  final VoidCallback quit;
  final VoidCallback answerMore;
  const CompletedDailyQuestions({Key? key,
  required this.quit,
  required this.answerMore}) : super(key: key);

  @override
  _CompletedDailyQuestionsState createState() => _CompletedDailyQuestionsState();
}

class _CompletedDailyQuestionsState extends State<CompletedDailyQuestions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      height: 500,
      child: Column(
        children:  [
          Spacer(),
          Text("Thank you for completing all of your daily questions."
,            textAlign: TextAlign.center,
            style: TextStyle(

                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          Text("You have recieved XX seeds!",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          Spacer(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                TextButton(
                    child: const Text('Quit',
                      style: const TextStyle(
                        fontSize: 15,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      widget.quit();
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: const Color.fromRGBO(2, 152, 89, 1),
                      elevation: 5,
                      fixedSize: const Size(145, 60),

                    ),

                ),
                const Spacer(),
                TextButton(
                  child: Text('Answer more questions',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    widget.answerMore();
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: const Color.fromRGBO(2, 152, 89, 1),
                    elevation: 5,
                    fixedSize: const Size(145, 60),
                  ),
                )

              ],
            ),
          )
        ],
      )
    );
  }
}


