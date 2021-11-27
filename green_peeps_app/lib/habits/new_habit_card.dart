import 'package:flutter/material.dart';

class NewHabitCard extends StatelessWidget {
  final String title;
  final String info;
  final int points;
  final int amount;

  const NewHabitCard({Key? key, required this.title,
  required this.info,
  required this.points,
  required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: const Color.fromRGBO(248, 244, 219, 1),
        elevation: 10,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                // alignment: Alignment.centerLeft,
                child: Text(
                  "Leaves: ${points}",
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  info,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      // Used to make the bar round
                      borderRadius: BorderRadius.circular(10),
                      child: const LinearProgressIndicator(
                        backgroundColor: Color.fromRGBO(180, 180, 180, 1),
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        value: 0.0,
                        minHeight: 25,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "0/${amount}" ,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),

                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                alignment: Alignment.center,
                child: Text(
                  "Do this habit ${amount} times",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ]
        )
    );
  }
}



