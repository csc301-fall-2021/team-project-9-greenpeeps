import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_peeps_app/habits/recommended_habit_item.dart';
import 'dart:math';
import 'package:green_peeps_app/services/habit_firestore.dart';

class RecommendedBox extends StatefulWidget {
  const RecommendedBox({Key? key}) : super(key: key);

  @override
  _RecommendedBoxState createState() => _RecommendedBoxState();
}

class _RecommendedBoxState extends State<RecommendedBox> {

  // get all habits from firebase
  // select three random habits
  Widget _listRecommendedHabits(Stream<QuerySnapshot> habits, Stream<DocumentSnapshot> userHabits) {
    //CollectionReference articles = FirebaseFirestore.instance.collection('articles');

    return StreamBuilder<QuerySnapshot>(
      stream: habits,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text("Come back later for more :)");
        return Container(child: _getArticles(snapshot, userHabits));
      }

    );
  }

  _getTestArticles(AsyncSnapshot<QuerySnapshot> snapshot, List<String> allHabitsList, List<String> userHabitsList) {
    List<String> filteredHabitsList = [];
    for (var habitKey in allHabitsList) {
      if (!userHabitsList.contains(habitKey)) {
        filteredHabitsList.add(habitKey);
      }
    }

    print("TEST ARTICLES: " + filteredHabitsList.toString());

    List<RecommendedHabitItem> habitsList = [];
    for (var doc in snapshot.data!.docs) { 
      habitsList.add(RecommendedHabitItem(hid: doc.id, title: doc["title"], info: doc["info"], amount: doc["amount"], points: doc["points"],));
    }

    if (habitsList.length >= 4) { // if random selection needs to be made
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

  _getArticles(AsyncSnapshot<QuerySnapshot> snapshot, Stream<DocumentSnapshot> userHabits) {

  // get all habits
  List<String> testLst = [];
  for (var element in snapshot.data!.docs) { testLst.add(element.id);}

  print("TEST REACHED: " + testLst.toString());

  return StreamBuilder<DocumentSnapshot>(
      stream: userHabits,
      builder: (context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.active) {
          var temp = userSnapshot.data;
          //if (!userSnapshot.hasData) return const Text("Come back later for more :)");
          
          if (temp!.data().toString().contains('habitInfo') == true) {
            Map<String, dynamic> testMap = temp.data() as Map<String, dynamic>;
            var lst = testMap['habitInfo'].keys.toList();
            print("USER SNAPSHOT: " + lst.toString());
            return ListView(shrinkWrap: true, children: _getTestArticles(snapshot, testLst, lst));
          } else {
            return ListView(shrinkWrap: true, children: []);
          }
          
        } else {
          return ListView(shrinkWrap: true, children: []);
        }
      }

  );
  }


  @override 
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> habits = FirebaseFirestore.instance.collection('habits').snapshots();
    Stream<DocumentSnapshot> userHabits = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots();

    //_test();
    //StreamBuilder<QuerySnapshot> testList = _listAllHabits(habits, userHabits);

    //print("TESTING: " + testList.toString());

    //_listRecommendedHabits(habits, userHabits);

    return SliverSafeArea(
      sliver: SliverPadding(
        padding: const EdgeInsets.only(
            left: 30, right: 30, top: 15, bottom: 0),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  <Widget>[
                  const Text(
                    "Recommended",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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