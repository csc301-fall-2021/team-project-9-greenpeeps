import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_peeps_app/habits/recommended_come_back_later.dart';
import 'package:green_peeps_app/habits/recommended_habit_item.dart';
import 'dart:math';

class RecommendedBox extends StatefulWidget {
  const RecommendedBox({Key? key}) : super(key: key);

  @override
  _RecommendedBoxState createState() => _RecommendedBoxState();
}

class _RecommendedBoxState extends State<RecommendedBox> {
  // get all habits from firebase
  // select three random habits
  Widget _listRecommendedHabits(
      Stream<QuerySnapshot> habits, Stream<DocumentSnapshot> userHabits) {
    //CollectionReference articles = FirebaseFirestore.instance.collection('articles');

    return StreamBuilder<QuerySnapshot>(
      stream: habits,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 150, vertical: 50),
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        return Container(
          child: _getNonUserHabits(snapshot, userHabits),
        );
      },
    );
  }

  _getNonUserHabits(AsyncSnapshot<QuerySnapshot> snapshot,
      Stream<DocumentSnapshot> userHabits) {
    // get all habits
    List<String> testLst = [];
    for (var element in snapshot.data!.docs) {
      testLst.add(element.id);
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: userHabits,
      builder: (context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.active) {
          var userData = userSnapshot.data;

          if (userData!.data().toString().contains('userHabits') == true) {
            Map<String, dynamic> userHabitsMap =
                userData.data() as Map<String, dynamic>;
            var userHabitKeys = userHabitsMap['userHabits'].keys.toList();
            var nonUserHabits = _filterHabits(snapshot, testLst, userHabitKeys);
            if (nonUserHabits.length > 0) {
              return ListView(shrinkWrap: true, children: nonUserHabits);
            } else {
              return const RecommendedComeBackLater();
            }
          } else {
            return const RecommendedComeBackLater();
          }
        } else {
          return const RecommendedComeBackLater();
        }
      },
    );
  }

  _filterHabits(AsyncSnapshot<QuerySnapshot> snapshot,
      List<String> allHabitsList, List<String> userHabitsList) {
    List<String> filteredHabitsList = [];
    for (var habitKey in allHabitsList) {
      if (!userHabitsList.contains(habitKey)) {
        filteredHabitsList.add(habitKey);
      }
    }

    List<RecommendedHabitItem> habitsList = [];
    for (var doc in snapshot.data!.docs) {
      // should be in filteredhabitslist
      if (filteredHabitsList.contains(doc.id)) {
        habitsList.add(
          RecommendedHabitItem(
            hid: doc.id,
            title: doc["title"],
            info: doc["info"],
            amount: doc["amount"],
            points: doc["points"],
          ),
        );
      }
    }

    if (habitsList.length >= 4) {
      // if random selection needs to be made
      List<RecommendedHabitItem> randomHabitsList = [];
      // select 3 random habits
      while (randomHabitsList.length < 3) {
        int _randInt = Random().nextInt(habitsList.length);
        if (!randomHabitsList.contains(habitsList[_randInt])) {
          randomHabitsList.add(habitsList[_randInt]);
        }
      }
      return randomHabitsList;
    } else {
      return habitsList;
    }
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> habits =
        FirebaseFirestore.instance.collection('habits').snapshots();
    Stream<DocumentSnapshot> userHabits = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return SliverSafeArea(
      sliver: SliverPadding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 0),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: const <Widget>[
                    Text(
                      "Recommended",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.add_task_rounded,
                    ),
                  ]),
                  _listRecommendedHabits(habits, userHabits),
                ],
              );
            },
            childCount: 1,
          ),
        ),
      ),
    );
  }
}
