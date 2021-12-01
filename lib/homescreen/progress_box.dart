import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProgressBox extends StatefulWidget {
  const ProgressBox({Key? key}) : super(key: key);

  @override
  _ProgressBoxState createState() => _ProgressBoxState();
}

class _ProgressBoxState extends State<ProgressBox> {
  // Box Variables
  final double _boxPadding = 10.0;
  final double _boxElevation = 5.0; // The height of shadow beneath box
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);

  Widget _buildSecondBox(
      BuildContext context,
      double boxPadding,
      double boxElevation,
      Color boxColor,
      int totalPoints) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Material(
            color: boxColor,
            elevation: boxElevation,
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              padding: EdgeInsets.all(boxPadding),
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // Use the minimum space necessary to fit all widgets
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Everything starts fartest left
                children: <Widget>[
                  Text(
                    "You are " +
                        (50 - totalPoints % 50).toString() +
                        " seeds away from your next leaf!",
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Divider(
                      color: boxColor), // Adds some room between these widgets
                  ClipRRect(
                    // Used to make the bar round
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      backgroundColor: const Color.fromRGBO(180, 180, 180, 1),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.green),
                      value: (totalPoints % 50) / 50,
                      minHeight: 10,
                    ),
                  ),
                ],
              ),
            ),
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

    int totalPoints;
    return StreamBuilder<DocumentSnapshot>(
        stream: users,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var userData = snapshot.data;

            if (userData!.data().toString().contains('totalPoints') == false) {
              totalPoints = 0;
            } else {
              totalPoints = userData["totalPoints"];
            }

            return _buildSecondBox(context, _boxPadding, _boxElevation,
                _boxColor, totalPoints);
          } else {
            return _buildSecondBox(
                context, _boxPadding, _boxElevation, _boxColor, 0);
          }
        });
  }
}
