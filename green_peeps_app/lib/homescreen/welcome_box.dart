import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_peeps_app/homescreen/info_dialog.dart';

class WelcomeBox extends StatefulWidget {
  const WelcomeBox({Key? key}) : super(key: key);

  @override
  _WelcomeBoxState createState() => _WelcomeBoxState();
}

class _WelcomeBoxState extends State<WelcomeBox> {
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
            child: Container(
              padding: EdgeInsets.all(boxPadding),
              child: Row(
                children: [
                  Text(
                    "Welcome " + userFirstName + "!",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: const Icon(Icons.help_outline_rounded,
                      size: 30,
                    ),
                    tooltip: 'Help',
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return InfoDialog();
                          }
                      );
                    },
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
