import 'package:flutter/material.dart';
import 'package:green_peeps_app/homescreen/pie_diagram.dart';

import 'package:green_peeps_app/homescreen/first_box.dart';
import 'package:green_peeps_app/homescreen/articles_box.dart';
import 'package:green_peeps_app/homescreen/second_box.dart';
import 'package:green_peeps_app/homescreen/daily_questions_box.dart';
import 'package:green_peeps_app/homescreen/daily_habits_box.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  final double _boxPadding = 10.0;
  final double _boxElevation = 5.0; // The height of shadow beneath box
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);

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
                    "Welcome " + userFirstName + "!",
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
                          color: Colors.orange, shape: BoxShape.circle),
                    )),
              ]));
        },
        childCount: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CustomScrollView(slivers: <Widget>[
      SliverSafeArea(
        sliver: SliverPadding(
          padding: EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 25),
          sliver: _buildFirstBox(
              context, _boxPadding, _boxElevation, _boxColor, "Hayden"),
        ),
      ),
    ]));
  }
}
