import 'package:flutter/material.dart';
import 'package:green_peeps_app/habits/first_box.dart';
import 'package:green_peeps_app/habits/recommended_box.dart';
import 'package:green_peeps_app/habits/habits_in_progress_section.dart';
import 'package:green_peeps_app/habits/my_habits_section.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({Key? key}) : super(key: key);

  @override
  _HabitsScreenState createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Center(
      // List of scrollable widgets
      // You can customize to space between each widget/ box
      child: Scrollbar(
        controller: _controller,
        child: CustomScrollView(
          controller: _controller,
          slivers: <Widget>[
            const SliverSafeArea(
              sliver: SliverPadding(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 0),
                sliver: FirstBox(),
              ),
            ),
            const RecommendedBox(),
            SliverSafeArea(
              sliver: SliverPadding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 15, bottom: 0),
                sliver: HabitsInProgressSection(),
              ),
            ),
            SliverSafeArea(
              sliver: SliverPadding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 15, bottom: 25),
                sliver: MyHabitsSection(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
