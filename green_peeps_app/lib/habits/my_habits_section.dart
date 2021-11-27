import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_peeps_app/habits/habit_tile_info.dart';
import 'package:green_peeps_app/habits/habit_tile_info_dialogue.dart';
import 'package:green_peeps_app/services/habit_firestore.dart';

class MyHabitsSection extends StatefulWidget {
  const MyHabitsSection({Key? key}) : super(key: key);

  @override
  _MyHabitsSectionState createState() => _MyHabitsSectionState();
}

class _MyHabitsSectionState extends State<MyHabitsSection> {
  List completedhabitKeys = [];
  List completedhabitList = [];

  @override
  void initState() {
    super.initState();
    getCompletedHabitKeys().then(
      (result) {
        setState(
          () {
            completedhabitKeys = result;
            for (var key in completedhabitKeys) {
              getHabitFromStore(key).then(
                (r) {
                  setState(
                    () {
                      completedhabitList.add(r);
                    },
                  );
                },
              );
            }
          },
        );
      },
    );
  }

  getCompletedHabitKeys() async {
    var userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (userSnapshot.exists && userSnapshot['allHabits'] != null) {
      var habitKeys = userSnapshot['allHabits'].keys.toList();
      var copyKeys = [...habitKeys];
      for (var key in copyKeys) {
        if (userSnapshot['allHabits'][key]['completed'] == false) {
          habitKeys.remove(key);
        }
      }
      return habitKeys;
    } else {
      return [];
    }
  }

  Widget _buildMyHabitsSection(BuildContext context) {
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
                      "Completed Habits",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.auto_awesome_rounded,
                    ),
                  ],
                ),
              ),
              Material(
                color: const Color.fromRGBO(248, 244, 219, 1),
                borderRadius: BorderRadius.circular(5.0),
                elevation: 5,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: completedhabitList.length,
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
                              habitName: completedhabitList[index].title,
                              habitDescription: completedhabitList[index].info),
                          const Divider(
                            color: Colors.grey,
                          )
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
    return _buildMyHabitsSection(context);
  }
}
