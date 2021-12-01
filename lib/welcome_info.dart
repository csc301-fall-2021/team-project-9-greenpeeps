import 'package:flutter/material.dart';


class WelcomeInfo extends StatelessWidget {
  const WelcomeInfo({Key? key}) : super(key: key);
// Color.fromRGBO(157, 207, 148, 1), bg
  final _boxColour = const Color.fromRGBO(248, 244, 219, 1);
  final TextStyle style = const TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: "Nunito",
    fontWeight: FontWeight.w700,
  );

  Widget _card1(){
    return Card(
      color: _boxColour,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text("GreenPeeps is on a mission to help people to develop more climate friendly habits. "
                  "We do this by learning about you, teaching you important lessons about how your habits generate emissions, "
                  "and then helping you to find new more climate friendly habits. ",
                style: style,
              ),
            ),
          ]
      ),
    );
  }

  Widget _card2(){
    return Card(
      color: _boxColour,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text("With your help, we hope to make a collective impact to avoid the worst outcomes of climate change. "
                  "Every government must contribute to this change, "
                  "and while we push for that, we can all do our own part to make change "
                  "toward long-term sustainability for our people on this planet. ",
                style: style,
              ),
            ),
          ]
      ),
    );
  }

  Widget _card3(){
    return Card(
      color: _boxColour,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text("Oh... and on behalf of the GreenPeeps team, "
                  "we want to thank you for your interest in making a difference for climate change and for checking us out. "
                  "We always love your feedback and please send your thoughts and suggestions to Feedback@GreenPeeps.com",
                style: style,
              ),
            ),
          ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(157, 207, 148, 1),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _card1(),
                _card2(),
                _card3(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: ElevatedButton(
                    onPressed:() async {
                      Navigator.popAndPushNamed(context, '/init_questionnaire_intro');
                    },
                    child: Text("Let's Go!",
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
          ),
        )
    );
  }
}




