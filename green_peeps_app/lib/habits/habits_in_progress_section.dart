import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_peeps_app/habits/habit_buttons.dart';
import 'package:green_peeps_app/habits/habit_tile_info.dart';
import 'package:green_peeps_app/habits/habit_tile_info_dialogue.dart';
import 'package:green_peeps_app/habits/habit_tile_progress_bar.dart';
import 'package:green_peeps_app/models/habit.dart';
import 'package:green_peeps_app/services/habit_firestore.dart';

class HabitsInProgressSection extends StatefulWidget {
  const HabitsInProgressSection({Key? key}) : super(key: key);

  @override
  _HabitsInProgressSectionState createState() =>
      _HabitsInProgressSectionState();
}

class _HabitsInProgressSectionState extends State<HabitsInProgressSection> {
  // List allHabitKeys = [];
  // List allHabitList = [];

  // @override
  // void initState() {
  //   super.initState();
  //   getHabitKeys().then((result) {
  //     setState(() {
  //       allHabitKeys = result;
  //       for (var key in allHabitKeys) {
  //         getHabitFromStore(key).then((r) {
  //           getRepsFromDB(key).then((t) {
  //             setState(() {
  //               r!.reps = t;
  //             });
  //           });
  //           setState(() {
  //             allHabitList.add(r);
  //           });
  //         });
  //       }
  //     });
  //   });
  // }

  // getRepsFromDB(key) async {
  //   var userSnapshot = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   if (userSnapshot.exists && userSnapshot['userHabits'] != null) {
  //     return userSnapshot['userHabits'][key]['reps'];
  //   } else {
  //     return 0;
  //   }
  // }

  // // Fetch Habit IDs from user's habit list
  // getHabitKeys() async {
  //   var userSnapshot = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   if (userSnapshot.exists && userSnapshot['userHabits'] != null) {
  //     var habitKeys = userSnapshot['userHabits'].keys.toList();
  //     var copyKeys = [...habitKeys];
  //     for (var key in copyKeys) {
  //       if (userSnapshot['userHabits'][key]['completed']) {
  //         habitKeys.remove(key);
  //       }
  //     }
  //     return habitKeys;
  //   } else {
  //     return [];
  //   }
  // }

  Widget _buildHabitsInProgressSection(
      BuildContext context, List<Habit> habitList) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      "Habits In Progress",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.assignment_rounded,
                    ),
                  ],
                ),
              ),
              const HabitButtons(),
              const Divider(),
              Material(
                color: const Color.fromRGBO(248, 244, 219, 1),
                borderRadius: BorderRadius.circular(5.0),
                elevation: 5,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: habitList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          HabitTileInfo(
                              habitNum: index + 1,
                              habitName: habitList[index].title,
                              habitDescription: habitList[index].info),
                          HabitProgressBar(
                            userCompleted: habitList[index].reps,
                            userTotal: habitList[index].totalAmount,
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        childCount: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot> users = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    Stream<QuerySnapshot<Map<String, dynamic>>> habits =
        FirebaseFirestore.instance.collection('habits').snapshots();

    return StreamBuilder<DocumentSnapshot>(
        stream: users,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            List allHabitKeys = [];
            List<Habit> allHabitList = [];
            var userData = snapshot.data;
            allHabitKeys = userData!['userHabits'].keys.toList();

            return StreamBuilder<QuerySnapshot>(
              stream: habits,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot2) {
                if (snapshot2.connectionState == ConnectionState.active) {
                  var habitData = snapshot2.data;
                  for (var doc in habitData!.docs) {
                    if (allHabitKeys.contains(doc.id) && !userData['userHabits'][doc.id]['completed']) {
                      Map<String, dynamic> data =
                          doc.data()! as Map<String, dynamic>;
                      var newHabit = Habit(
                          id: doc.id,
                          title: data['title'],
                          info: data['info'],
                          hid: data['hid'],
                          totalAmount: data['amount'],
                          points: data['points'],
                          reps: userData['userHabits'][doc.id]['reps']);
                      allHabitList.add(newHabit);
                    }
                  }
                  return _buildHabitsInProgressSection(context, allHabitList);
                } else {
                  return _buildHabitsInProgressSection(context, []);
                }
              },
            );
          } else {
            return _buildHabitsInProgressSection(context, []);
          }
        });
  }
}