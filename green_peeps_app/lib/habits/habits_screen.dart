import 'package:flutter/material.dart';
import 'package:green_peeps_app/habits/title_box.dart';
import 'package:green_peeps_app/habits/recommended_box.dart';
import 'package:green_peeps_app/habits/habits_in_progress_section.dart';
import 'package:green_peeps_app/habits/my_habits_section.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({Key? key}) : super(key: key);

  @override
  _HabitsScreenState createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  @override
  final ScrollController _controller = ScrollController();

  Widget build(BuildContext context) {
    return Center(
      child: Scrollbar(
        controller: _controller,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomScrollView(
            controller: _controller,
            slivers: const <Widget>[
              SliverSafeArea(
                sliver: SliverPadding(
                  padding:
                      EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 0),
                  sliver: TitleBox(),
                ),
              ),
              RecommendedBox(),
              SliverSafeArea(
                sliver: SliverPadding(
                  padding:
                      EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 0),
                  sliver: HabitsInProgressSection(),
                ),
              ),
              SliverSafeArea(
                sliver: SliverPadding(
                  padding:
                      EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 25),
                  sliver: MyHabitsSection(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
