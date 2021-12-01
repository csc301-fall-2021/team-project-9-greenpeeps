import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AchievementsBox extends StatefulWidget {
  const AchievementsBox({Key? key}) : super(key: key);

  @override
  _AchievementsBoxState createState() => _AchievementsBoxState();
}

class _AchievementsBoxState extends State<AchievementsBox> {
  // Box Variables
  final double _boxPadding = 10.0;
  final double _boxElevation = 5.0; // The height of shadow beneath box
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);
  // First box when looking at boxes from top to bottom
  // (consider making each box its own dart file)
  final _scrollController = ScrollController();
  var isVisible = true;

  Widget _buildThirdBox(
      BuildContext context,
      double boxPadding,
      double boxElevation,
      Color boxColor,
      ScrollController _scrollController,
      List text,
      List image) {
    final children = <Widget>[];
    final children2 = <Widget>[];
    if (text.isNotEmpty) {
      for (int i = 0; i < text.length; i++) {
        if (i < 5) {
          children.add(new Container(
              padding: EdgeInsets.all(boxPadding),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(IconData(image[i], fontFamily: 'MaterialIcons'),
                        size: 40),
                    Text(
                      text[i],
                      style: TextStyle(fontSize: 28),
                    )
                  ])));
        }
      }
      for (int i = 0; i < image.length; i++) {
        children2.add(new Container(
            padding: EdgeInsets.all(boxPadding),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(IconData(image[i], fontFamily: 'MaterialIcons'),
                      size: 40)
                ])));
      }
    } else {
      children2.add(
          new Container(padding: EdgeInsets.all(boxPadding), child: Text("")));
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (isVisible == true) {
            return Material(
                color: boxColor,
                elevation: boxElevation,
                borderRadius: BorderRadius.circular(5.0),
                child: InkWell(
                    onTap: () {
                      setState(() {
                        if (text.isNotEmpty) {
                          isVisible = !isVisible;
                        }
                      });
                    },
                    child: Visibility(
                        visible: isVisible,
                        child: Column(children: [
                          Container(
                            padding: EdgeInsets.all(boxPadding),
                            child: Text(
                              "Achievements",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.all(boxPadding),
                              child: Row(children: children2)),
                        ]))));
          } else {
            return Material(
                color: boxColor,
                elevation: boxElevation,
                borderRadius: BorderRadius.circular(5.0),
                child: InkWell(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: Visibility(
                        visible: !isVisible,
                        child: Column(children: [
                          Container(
                            padding: EdgeInsets.all(boxPadding),
                            child: Text(
                              "Achievements",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                              height: 300,
                              padding: EdgeInsets.all(boxPadding),
                              child: Scrollbar(
                                  isAlwaysShown: true,
                                  controller: _scrollController,
                                  child: SingleChildScrollView(
                                      controller: _scrollController,
                                      child: Column(children: children)))),
                        ]))));
          }
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
                    List achievementTitles = [];
                    List achievementIcons = [];
                    for (int i = 0; i < achievementData.length; i++) {
                      for (int j = 0; j < userAchievements.length; j++) {
                        if (userAchievements[j] == achievementData[i].id) {
                          achievementTitles.add(achievementData[i]['title']);
                          achievementIcons.add(achievementData[i]['icon']);
                        }
                      }
                    }
                    return _buildThirdBox(
                        context,
                        _boxPadding,
                        _boxElevation,
                        _boxColor,
                        _scrollController,
                        achievementTitles,
                        achievementIcons);
                  } else {
                    return _buildThirdBox(context, _boxPadding, _boxElevation,
                        _boxColor, _scrollController, [], []);
                  }
                });
          } else {
            return _buildThirdBox(context, _boxPadding, _boxElevation,
                _boxColor, _scrollController, [], []);
          }
        });
  }
}
