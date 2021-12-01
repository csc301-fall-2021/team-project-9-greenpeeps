import 'package:flutter/material.dart';
import 'package:green_peeps_app/profile/achievements_box.dart';
import 'package:green_peeps_app/profile/avatar_box.dart';
import 'package:green_peeps_app/profile/score_box.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  final double _boxPadding = 10.0;
  final double _boxElevation = 5.0; // The height of shadow beneath box
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);

  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scrollbar(
      controller: _controller,
      child: CustomScrollView(controller: _controller, slivers: <Widget>[
        const SliverSafeArea(
            sliver: SliverPadding(
          padding: EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 0),
          sliver: AvatarBox(),
        )),
        const SliverPadding(
          padding: EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 0),
          sliver: ScoreBox(),
        ),
        const SliverPadding(
          padding: EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 25),
          sliver: AchievementsBox(),
        )
      ]),
    ));
  }
}
