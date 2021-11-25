import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class RecommendedHabitDialogue extends StatefulWidget {
  final String hid;
  final String title;
  final String info;
  final int amount;
  final int points;

  const RecommendedHabitDialogue({Key? key, required this.hid, required this.title, required this.info, required this.amount, required this.points}) : super(key: key);

  @override
  _RecommendedHabitDialogueState createState() => _RecommendedHabitDialogueState();
}

class _RecommendedHabitDialogueState extends State<RecommendedHabitDialogue> {
  final double _boxPadding = 10.0;
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);

  final ButtonStyle style =
        ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            fontSize: 12,
          ),
          primary: Colors.green,
          maximumSize: const Size(120, 50),
          minimumSize: const Size(120, 50),
        );

  // "nFSUjg7UBookPXllvk0d"
  // FirebaseAuth.instance.currentUser!.uid

  _generateHabitDict() {
    Map<dynamic, dynamic> habitMap = <dynamic, dynamic>{'user_completed' : 0, 'completed': false};
    // add with hid as key
    return habitMap;
  }
  
  @override
  Widget build(BuildContext context) {
    return Dialog( 
      backgroundColor: _boxColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(_boxPadding + 5),
        width: double.infinity,
        height: 535,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              elevation: 0,
              toolbarHeight: 30,
              backgroundColor: _boxColor,
              automaticallyImplyLeading: false, // No back arrow
              actions: <Widget>[
                IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.of(context).pop(); // Closes popup
                  },
                  icon: const Icon(Icons.close),
                  color: Colors.black,
                  splashRadius: 15,
                )
              ],
            ),

            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Leaves: " + widget.points.toString()
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                widget.info
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Do this habit " + widget.amount.toString() + " times"
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: style,
                    onPressed: () {},
                    child: const Text(
                      'I already added this Habit',
                      textAlign: TextAlign.center,
                      ),
                  ),
                  ElevatedButton(
                    style: style,
                    onPressed: () => {
                      // _addHabit();
                      FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get()
                      .then((DocumentSnapshot snapshot) {
                        // if user doesn't have habit_info
                        if(!(snapshot.data().toString().contains("habit_info"))) {
                          FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set(
                            {'habit_info' : '{}'}, 
                            SetOptions(merge: true)
                          ).then((onValue) {
                            FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update(
                              {'habit_info.'+widget.hid : _generateHabitDict()},
                            );
                          });

                        // if user already has habit_info
                        } else {
                          // firebase structure automatically prevents repeats additions with the same key
                          // if doesn't already exist
                          if (!(snapshot.get(FieldPath(const ["habit_info"])).toString().contains(widget.hid))) {
                            FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update(
                              {'habit_info.'+widget.hid : _generateHabitDict()},
                            );
                          }
                          
                        }
                      })                  
                      
                    },
                    child: const Text(
                      'Add this to My Habits',
                      textAlign: TextAlign.center
                    ),
                  ),
                ]
              ),
            ),
            
          ]
        )
      )
    );
  }
}