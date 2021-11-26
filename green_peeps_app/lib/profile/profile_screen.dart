import 'package:flutter/material.dart';

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

  Widget _buildSecondBox(BuildContext context, double boxPadding,
      double boxElevation, Color boxColor, int userScore) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Material(
              color: boxColor,
              elevation: boxElevation,
              borderRadius: BorderRadius.circular(5.0),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(boxPadding),
                    child: Text(
                      userScore.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(boxPadding),
                      child: Image(
                        image: AssetImage("images/Leaf.png"),
                        height: 75,
                        width: 75,
                        alignment: Alignment.center,
                      ))
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ));
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
          padding: EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 0),
          sliver: _buildFirstBox(
              context, _boxPadding, _boxElevation, _boxColor, "Hayden"),
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 0),
        sliver:
            _buildSecondBox(context, _boxPadding, _boxElevation, _boxColor, 32),
      )
    ]));
  }
}
