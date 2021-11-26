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
  final _scrollController = ScrollController();
  var isVisible = true;

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

  Widget _buildThirdBox(BuildContext context, double boxPadding,
      double boxElevation, Color boxColor) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Material(
              color: boxColor,
              elevation: boxElevation,
              borderRadius: BorderRadius.circular(5.0),
              child: InkWell(
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  child: Visibility(
                      visible: isVisible,
                      child: Column(children: [
                        Container(
                          padding: EdgeInsets.all(boxPadding),
                          child: Text(
                            "Achievements",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(boxPadding),
                            child: Row(children: [
                              Container(
                                  padding: EdgeInsets.all(boxPadding),
                                  child: Image(
                                      image: AssetImage("images/Habits.png"),
                                      height: 50,
                                      width: 50)),
                              Container(
                                  padding: EdgeInsets.all(boxPadding),
                                  child: Image(
                                      image: AssetImage("images/Profile.png"),
                                      height: 50,
                                      width: 50))
                            ])),
                      ]))));
        },
        childCount: 1,
      ),
    );
  }

  Widget _buildFourthBox(BuildContext context, double boxPadding,
      double boxElevation, Color boxColor, ScrollController _scrollController) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Material(
              color: boxColor,
              elevation: boxElevation,
              borderRadius: BorderRadius.circular(5.0),
              child: InkWell(
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  child: Visibility(
                      visible: !isVisible,
                      child: Column(children: [
                        Container(
                          padding: EdgeInsets.all(boxPadding),
                          child: Text(
                            "Achievements",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                            height: 300,
                            padding: EdgeInsets.all(boxPadding),
                            child: Scrollbar(
                                isAlwaysShown: true,
                                controller: _scrollController,
                                child: SingleChildScrollView(
                                    controller: _scrollController,
                                    child: Column(children: [
                                      Container(
                                          padding: EdgeInsets.all(boxPadding),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Image(
                                                    image: AssetImage(
                                                        "images/Habits.png"),
                                                    height: 50,
                                                    width: 50),
                                                Text(
                                                  "A1",
                                                  style:
                                                      TextStyle(fontSize: 28),
                                                )
                                              ])),
                                      Container(
                                          padding: EdgeInsets.all(boxPadding),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Image(
                                                    image: AssetImage(
                                                        "images/Habits.png"),
                                                    height: 50,
                                                    width: 50),
                                                Text(
                                                  "A2",
                                                  style:
                                                      TextStyle(fontSize: 28),
                                                )
                                              ])),
                                      Container(
                                          padding: EdgeInsets.all(boxPadding),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Image(
                                                    image: AssetImage(
                                                        "images/Habits.png"),
                                                    height: 50,
                                                    width: 50),
                                                Text(
                                                  "A3",
                                                  style:
                                                      TextStyle(fontSize: 28),
                                                )
                                              ])),
                                      Container(
                                          padding: EdgeInsets.all(boxPadding),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Image(
                                                    image: AssetImage(
                                                        "images/Habits.png"),
                                                    height: 50,
                                                    width: 50),
                                                Text(
                                                  "A4",
                                                  style:
                                                      TextStyle(fontSize: 28),
                                                )
                                              ])),
                                      Container(
                                          padding: EdgeInsets.all(boxPadding),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Image(
                                                    image: AssetImage(
                                                        "images/Habits.png"),
                                                    height: 50,
                                                    width: 50),
                                                Text(
                                                  "A5",
                                                  style:
                                                      TextStyle(fontSize: 28),
                                                )
                                              ])),
                                      Container(
                                          padding: EdgeInsets.all(boxPadding),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Image(
                                                    image: AssetImage(
                                                        "images/Habits.png"),
                                                    height: 50,
                                                    width: 50),
                                                Text(
                                                  "A6",
                                                  style:
                                                      TextStyle(fontSize: 28),
                                                )
                                              ]))
                                    ])))),
                      ]))));
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
      ),
      SliverPadding(
        padding: EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 0),
        sliver: _buildThirdBox(context, _boxPadding, _boxElevation, _boxColor),
      ),
      SliverPadding(
        padding: EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 0),
        sliver: _buildFourthBox(
            context, _boxPadding, _boxElevation, _boxColor, _scrollController),
      )
    ]));
  }
}
