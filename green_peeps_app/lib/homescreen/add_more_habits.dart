import 'package:flutter/material.dart';

class AddHabit extends StatefulWidget {
  const AddHabit({Key? key, required this.title,
    required this.info,
    required this.amount,
    required this.points}) : super(key: key);
  final String title;
  final String info;
  final int amount;
  final int points;

  @override
  _AddHabitState createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  final ButtonStyle style =
  ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: 12,
    ),
    primary:  const Color.fromRGBO(2, 152, 89, 1),
    maximumSize: const Size(150, 60),
    minimumSize: const Size(150, 60),
  );


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 415,
      child: Column(
        children: [
          Container(
            height: 355,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Card(
                  color: const Color.fromRGBO(248, 244, 219, 1),

                  child: Column(
                    children: [
                      Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Leaves: ${widget.points}",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          widget.info,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                            "Do this habit ${widget.amount} times",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              // Used to make the bar round
                              borderRadius: BorderRadius.circular(10),
                              child: const LinearProgressIndicator(
                                backgroundColor: Color.fromRGBO(180, 180, 180, 1),
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                                value: 0.0,
                                minHeight: 16,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Text(
                                "0/${widget.amount}" ,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),

                              ),
                            )
                          ],
                        ),
                      ),]
                  )
                ),
                const Spacer(),
              ],
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  style: style,
                  onPressed: () {},
                  child: const Text(
                    'I already have this Habit',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  style: style,
                  onPressed: () {},
                  child: const Text(
                    'Add this to My Habits',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]
          ),
        ],
      )
    );
  }
}

