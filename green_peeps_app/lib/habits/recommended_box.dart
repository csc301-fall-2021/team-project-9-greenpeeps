import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  Widget _listRecommendedHabits(Stream<QuerySnapshot> habits) {
    //CollectionReference articles = FirebaseFirestore.instance.collection('articles');

    return StreamBuilder<QuerySnapshot>(
      stream: habits,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text("Come back later for more :)");
        return ListView(shrinkWrap: true, children: _getArticles(snapshot));
      }

    );
  }

  _getArticles(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<RecommendedHabitItem> habitsList = snapshot.data!.docs.map((doc) => RecommendedHabitItem(title: doc["title"], info: doc["info"], amount: doc["amount"], points: doc["points"],)).toList();

    if (habitsList.length >= 4) { // if random selection needs to be made
      List<RecommendedHabitItem> randomHabitsList = [];
      // select 3 random habits
      while (randomHabitsList.length <= 3) {
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

  // pass info to recommended habit item
  // display title inside

  // popup when plus button pressed
  // display info
  // proceed as according to UI


  @override 
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> habits = FirebaseFirestore.instance.collection('habits').snapshots();

    return SliverSafeArea(
      sliver: SliverPadding(
        padding: const EdgeInsets.only(
            left: 30, right: 30, top: 15, bottom: 0),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Recommended",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _listRecommendedHabits(habits),
                  /*ListView(
                    shrinkWrap: true,
                    children: const <Widget>[
                      Text("test"),
                      Text("Test2"),
                      Text("test3"),
                    ],
                  ),*/
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