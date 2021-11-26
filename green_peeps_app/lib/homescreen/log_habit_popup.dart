import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogHabitPopup extends StatefulWidget {
  const LogHabitPopup({Key? key}) : super(key: key);

  @override
  _LogHabitPopup createState() => _LogHabitPopup();
}

class _LogHabitPopup extends State<LogHabitPopup> {
  // Current index of which popup view to look at
  int _popupIndex = 0;

  // Map of which checkboxes are checked
  Map<int, bool> _habitMap = {};
  List habitList = [
    "Use Kettle",
    "Turn off Lights",
    "Recycle",
    "Turn off Computer",
    "Be Green",
    "Filler 1",
    "Filler 2"
  ];

  // Box Variables
  final double _boxPadding = 10.0;
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);

  // Database Information

  // Changes popup view being viewed
  void _setIndex(setState, int newIndex) {
    setState(
      () {
        if (_popupIndex == 0) {
          _popupIndex = 1;
        } else {
          _popupIndex = 0;
        }
      },
    );
  }

  Widget _makeHabitCheckbox(setState, String habitName, int habitID) {
    if (_habitMap[habitID] == null) {
      _habitMap[habitID] = false;
    }
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('habits')
            .doc(habitName)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return CheckboxListTile(
              title: Text(data['title']),
              activeColor: const Color.fromRGBO(0, 154, 6, 1),
              controlAffinity: ListTileControlAffinity.leading,
              value: _habitMap[habitID],
              onChanged: (bool? value) {
                setState(
                  () {
                    _habitMap[habitID] = value!;
                  },
                );
              },
            );
          } else {
            return CheckboxListTile(
              title: const Text('None'),
              activeColor: const Color.fromRGBO(0, 154, 6, 1),
              controlAffinity: ListTileControlAffinity.leading,
              value: _habitMap[habitID],
              onChanged: (bool? value) {
                setState(
                  () {
                    _habitMap[habitID] = value!;
                  },
                );
              },
            );
          }
        });
  }

  // The first view of the popups
  Widget _buildQuestionPopupOne(
      BuildContext context, double boxPadding, Color boxColor, List habitList) {
    return Dialog(
      insetPadding: EdgeInsets.all(15),
      backgroundColor: boxColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(boxPadding + 5),
        width: double.infinity,
        height: 600,
        child: Column(
          children: <Widget>[
            AppBar(
              elevation: 0,
              toolbarHeight: 30,
              backgroundColor: boxColor,
              automaticallyImplyLeading: false, // No back arrow
              actions: <Widget>[
                IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.of(context).pop(); // Closes popup
                  },
                  icon: const Icon(Icons.close),
                  color: Colors.black,
                  splashRadius: 15,
                )
              ],
            ),
            const Text(
              "What habits have you completed today?",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 415,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var i = 0; i < habitList.length; i++)
                    _makeHabitCheckbox(setState, habitList[i], i),
                  ]
                ),
              ),
            ),
            // const Expanded(child: Divider()),
            Row(
              children: <Widget>[
                const Spacer(),
                TextButton(
                  child: const Text('Save'),
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: const Color.fromRGBO(2, 152, 89, 1),
                    elevation: 5,
                    fixedSize: const Size(61, 25),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            var habitInfo = data['habitInfo'];
            var habitList = habitInfo.keys.toList();

            List<Widget> _popupViews = <Widget>[
              _buildQuestionPopupOne(context, _boxPadding, _boxColor, habitList),
            ];

            return SingleChildScrollView(
              child: _popupViews.elementAt(_popupIndex),
            );
          } else {
            List<Widget> _popupViews = <Widget>[
              _buildQuestionPopupOne(context, _boxPadding, _boxColor, habitList),
            ];
            return SingleChildScrollView(
              child: _popupViews.elementAt(_popupIndex),
            );
          }
        });
  }
}
