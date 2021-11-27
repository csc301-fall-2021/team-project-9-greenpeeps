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
          maximumSize: const Size(150, 75),
          minimumSize: const Size(150, 75),
        );

  // dev testing: "nFSUjg7UBookPXllvk0d"
  // prod: FirebaseAuth.instance.currentUser!.uid

  _generateHabitDict() {
    Map<dynamic, dynamic> habitMap = <dynamic, dynamic>{'user_completed' : 0, 'completed': false};
    // add with hid as key
    return habitMap;
  }

  _generateCompletedHabitDict() {
    Map<dynamic, dynamic> habitMap = <dynamic, dynamic>{'user_completed' : 0, 'completed': true};
    // add with hid as key
    return habitMap;
  }
  
  @override
  Widget build(BuildContext context) {
    return Dialog( 
      backgroundColor: _boxColor,
      insetPadding: EdgeInsets.all(15),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(_boxPadding + 5),
        width: double.infinity,
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
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Leaves: ${widget.points}",
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
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: style,
                    onPressed: () {
                      FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get()
                      .then((DocumentSnapshot snapshot) {
                        // if habitInfo doesn't exist yet
                        if(!(snapshot.data().toString().contains("habitInfo"))) {
                          FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set(
                            {'habitInfo' : '{}'}, 
                            SetOptions(merge: true)
                          ).then((onValue) {
                            FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update(
                              {'habitInfo.'+widget.hid : _generateCompletedHabitDict()},
                            );
                          });

                        // if user already has habitInfo
                        } else {
                          // update the appropriate habit inside habitInfo
                            FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update(
                              {'habitInfo.'+widget.hid : _generateCompletedHabitDict()},
                            );
                        }
                      });
                    },
                    child: const Text(
                      'I already preform this habit in my life',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                  ),
                  ElevatedButton(
                    style: style,
                    onPressed: () => {
                      FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get()
                      .then((DocumentSnapshot snapshot) {
                        // if user doesn't have habitInfo
                        if(!(snapshot.data().toString().contains("habitInfo"))) {
                          FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set(
                            {'habitInfo' : '{}'}, 
                            SetOptions(merge: true)
                          ).then((onValue) {
                            FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update(
                              {'habitInfo.'+widget.hid : _generateHabitDict()},
                            );
                          });

                        // if user already has habitInfo
                        } else {
                          // firebase structure automatically prevents repeats additions with the same key
                          // if doesn't already exist
                          if (!(snapshot.get(FieldPath(const ["habitInfo"])).toString().contains(widget.hid))) {
                            FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update(
                              {'habitInfo.'+widget.hid : _generateHabitDict()},
                            );
                          }
                          
                        }
                      })                  
                      
                    },
                    child: const Text(
                      'Add this to Habits In Progress',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ]
              ),
            ),
            SizedBox(height: 10),
          ]
        )
      )
    );
  }
}