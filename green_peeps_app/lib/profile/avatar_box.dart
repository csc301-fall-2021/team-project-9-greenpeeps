import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AvatarBox extends StatefulWidget {
  const AvatarBox({Key? key}) : super(key: key);

  @override
  _AvatarBoxState createState() => _AvatarBoxState();
}

class _AvatarBoxState extends State<AvatarBox> {
  // Box Variables
  final double _boxPadding = 10.0;
  final double _boxElevation = 5.0; // The height of shadow beneath box
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);
  // First box when looking at boxes from top to bottom
  // (consider making each box its own dart file)
  Widget _buildFirstBox(BuildContext context, double boxPadding,
      double boxElevation, Color boxColor, String userFirstName) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Material(
              color: boxColor,
              elevation: boxElevation,
              borderRadius: BorderRadius.circular(5.0),
              child: Column(children: [
                Container(
                  padding: EdgeInsets.all(boxPadding),
                  child: Text(
                    userFirstName,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(boxPadding),
                    child: Container(
                      padding: EdgeInsets.all(150.0),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/Ellipse1.png')),
                          color: Colors.orange,
                          shape: BoxShape.circle),
                    )),
              ]));
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

    return StreamBuilder<DocumentSnapshot>(
        stream: users,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var userData = snapshot.data;
            var userFirstName = userData!['firstName'];

            return _buildFirstBox(
                context, _boxPadding, _boxElevation, _boxColor, userFirstName);
          } else {
            return _buildFirstBox(
                context, _boxPadding, _boxElevation, _boxColor, "");
          }
        });
  }
}
