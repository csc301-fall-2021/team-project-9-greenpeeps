import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScoreBox extends StatefulWidget {
  const ScoreBox({Key? key}) : super(key: key);

  @override
  _ScoreBoxState createState() => _ScoreBoxState();
}

class _ScoreBoxState extends State<ScoreBox> {
  // Box Variables
  final double _boxPadding = 10.0;
  final double _boxElevation = 5.0; // The height of shadow beneath box
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);
  // First box when looking at boxes from top to bottom
  // (consider making each box its own dart file)
  Widget _buildSecondBox(BuildContext context, double boxPadding,
      double boxElevation, Color boxColor, int userScore) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Material(
              color: boxColor,
              elevation: boxElevation,
              borderRadius: BorderRadius.circular(5.0),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(boxPadding),
                    child: Text(
                      userScore.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(boxPadding),
                      child: Image(
                        image: AssetImage("images/Leaf.png"),
                        height: 75,
                        width: 75,
                        alignment: Alignment.center,
                      ))
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ));
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

    Stream<QuerySnapshot<Map<String, dynamic>>> achievements =
        FirebaseFirestore.instance.collection('achievements').snapshots();

    return StreamBuilder<DocumentSnapshot>(
        stream: users,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var userData = snapshot.data;
            var userScore = userData!['totalPoints'];
            var userAchievements = userData['achievements'];

            return StreamBuilder<QuerySnapshot>(
                stream: achievements,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot2) {
                  if (snapshot2.connectionState == ConnectionState.active) {
                    var achievementData = snapshot2.data!.docs;
                    for (int i = 0; i < achievementData.length; i++) {
                      for (int j = 0; j < userAchievements.length; j++) {
                        if (userAchievements[j] == achievementData[i].id) {
                          userScore = userScore + achievementData[i]['score'];
                        }
                      }
                    }
                    userScore = userScore / 50;
                    return _buildSecondBox(context, _boxPadding, _boxElevation,
                        _boxColor, userScore.floor());
                  } else {
                    return _buildSecondBox(
                        context, _boxPadding, _boxElevation, _boxColor, 0);
                  }
                });
          } else {
            return _buildSecondBox(
                context, _boxPadding, _boxElevation, _boxColor, 0);
          }
        });
  }
}
