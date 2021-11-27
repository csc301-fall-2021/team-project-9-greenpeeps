import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_peeps_app/habits/habit_tile_info.dart';
import 'package:green_peeps_app/habits/habit_tile_info_dialogue.dart';
import 'package:green_peeps_app/services/habit_firestore.dart';

// List habitList = ["Turn off Computer", "Be Green", "Filler 1", "Filler 2"];

class MyHabitsSection extends StatefulWidget {
  const MyHabitsSection({Key? key}) : super(key: key);

  @override
  _MyHabitsSectionState createState() => _MyHabitsSectionState();
}

class _MyHabitsSectionState extends State<MyHabitsSection> {
  List habitKeys = [];
  List habitList = [];
  @override
  void initState() {
    super.initState();
    getHabitKeys().then((result) {
      setState(() {
        habitKeys = result;
        for (var key in habitKeys) {
          getHabitFromStore(key).then((r) {
            setState(() {
              habitList.add(r);
            });
          });
        }
      });
    });
  }

  getHabitKeys() async {
    var userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (userSnapshot.exists) {
      habitKeys = userSnapshot['habitInfo'].keys.toList();
      return habitKeys;
    } else {
      return null;
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
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "My Habits",
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
                          Divider(
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