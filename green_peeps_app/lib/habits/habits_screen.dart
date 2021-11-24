import 'package:flutter/material.dart';
import 'package:green_peeps_app/habits/first_box.dart';
import 'package:green_peeps_app/habits/recommended_box.dart';
import 'package:green_peeps_app/habits/recommended_section.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({Key? key}) : super(key: key);

  @override
  _HabitsScreenState createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      // List of scrollable widgets
      // You can customize to space between each widget/ box
      child: CustomScrollView(
        slivers: <Widget>[
          const SliverSafeArea(
            sliver: SliverPadding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 0),
              sliver: FirstBox(),
            ),
          ),
          const RecommendedBox(),
          SliverSafeArea(
            sliver: SliverPadding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 15, bottom: 0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return const Text(
                      "Habits In Progress",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                  childCount: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
