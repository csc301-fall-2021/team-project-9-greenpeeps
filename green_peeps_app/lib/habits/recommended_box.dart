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

    /*List userHabitKeys = [];
    List habitKeys = [];
    List nonUserHabitKeys = [];
    List nonUserHabitsList = [];
    @override 
    void initState() {
      super.initState();
      getUserHabitKeys().then((userHabitKeysResult) {
        setState(() {
          userHabitKeys = userHabitKeysResult;
          getHabitKeys().then((habitKeysResult) {
            setState(() {
              habitKeys = habitKeysResult;
              // get only habits user doesn't have
              for (var key in habitKeys) {
                if (!userHabitKeys.contains(key)) {
                  nonUserHabitKeys.add(key);
                }
              }
              for (var key in habitKeys) {
                getHabitFromStore(key).then((r) {
                  setState(() {
                    nonUserHabitsList.add(r);
                  });
                });
              }
            });
          });
        });
      });
    }*/

    /*getUserHabitKeys() async {
      var userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (userSnapshot.exists) {
        userHabitKeys = userSnapshot['habitInfo'].keys.toList();
        return userHabitKeys;
      } else {
        return null;
      }     

    }*/

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

// FirebaseAuth.instance.currentUser!.uid
  /*_test(QueryDocumentSnapshot<Object?> doc) {
    
    /*if (
      FirebaseFirestore.instance
      .collection('users')
      .doc("wNerzhxjCpf0so9mHQnab8BWjo52")
      .get() ?? true)
    {*/
    Stream<DocumentSnapshot> users = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    
      /*FirebaseFirestore.instance
      .collection('users')
      .doc("wNerzhxjCpf0so9mHQnab8BWjo52")
      .get()
      .then((DocumentSnapshot docSnapshot) {
        print("HERE: " + docSnapshot.get(FieldPath(const ["habitInfo"])).toString());
        // if user has habits added
        if(docSnapshot.get(FieldPath(const ["habitInfo"])).toString().contains(doc.id)) {
          // get those habits
          // turn into map
          return true;

        } else {return false;}
      });*/
    /*} else {
      print("NULL REACHED");
    }*/
    
  }*/

  _getArticles(AsyncSnapshot<QuerySnapshot> snapshot) {
    /*FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .get()
    .then((DocumentSnapshot snapshot) {
      // if user has habits added
      if(snapshot.data().toString().contains("habitInfo")) {
        // get those habits
        // turn into map

      }
    });*/

    

    // get user habits
    // turn to map
    // if id in user habits, pass, otherwise, do stuff
    List<RecommendedHabitItem?> unfilteredHabitsList = snapshot.data!.docs
    .map(
      (doc) => RecommendedHabitItem(hid: doc.id, title: doc["title"], info: doc["info"], amount: doc["amount"], points: doc["points"],)
    )
    .toList();

    unfilteredHabitsList.removeWhere((element) => element == null);
    //final List<RecommendedHabitItem> habitsList = unfilteredHabitsList.whereType<RecommendedHabitItem>().toList();
    final habitsList = List<RecommendedHabitItem>.from(unfilteredHabitsList);

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