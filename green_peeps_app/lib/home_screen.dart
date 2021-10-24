import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:green_peeps_app/question_popup.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class PieDiagram extends StatelessWidget {
  PieDiagram({Key? key}) : super(key: key);

  final List<Color> _pieChartColors = <Color>[
    Colors.teal.shade200,
    Colors.teal.shade300,
    Colors.teal.shade400,
    Colors.teal,
    Colors.teal.shade600,
    Colors.teal.shade700,
    Colors.teal.shade800,
    Colors.teal.shade900
  ];

  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot> users = FirebaseFirestore.instance
        .collection('users')
        .doc('nFSUjg7UBookPXllvk0d')
        .snapshots();

    return StreamBuilder<DocumentSnapshot>(
      stream: users,
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          var userData = snapshot.data;
          Map<String, double> carbonEmissions = Map<String, double>.from(userData!["carbonEmissions"]);


          return PieChart(
            dataMap: carbonEmissions,
            chartLegendSpacing: 25,
            chartRadius: MediaQuery.of(context).size.width /
                2, // Half the width of the screen
            colorList: _pieChartColors,
            legendOptions: const LegendOptions(
              showLegendsInRow: true,
              legendPosition: LegendPosition.bottom,
              legendTextStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: false,
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Box Variables
  final double _boxPadding = 10.0;
  final double _boxElevation = 5.0; // The height of shadow beneath box
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);

  // Database Information
  // (could you make getters and setters for this when you database things)
  final String _userFirstName = "Human";
  final double _progressCompleted = 0.5; // Must be from 0 to 1
  final int _progressLeft = 50; // Represented in amount of points
  final String _funFact =
      "Did you know that some house centipedes are poisonous. Additionally, house centipedes can sometimes regenerate their legs if they have been cut off. Trust me, I know from experience!";

  // User's carbon emmissions breakdown from database
  final Map<String, double> _pieChartCategories = {
    "Food": 5,
    "Electricity": 3,
    "Water": 2,
    "Transportation": 2,
  };

  final List<Color> _pieChartColors = <Color>[
    Colors.teal.shade200,
    Colors.teal.shade300,
    Colors.teal.shade400,
    Colors.teal,
    Colors.teal.shade600,
    Colors.teal.shade700,
    Colors.teal.shade800,
    Colors.teal.shade900
  ];

  // Updates the pie chart widget with new values when a question has been answered
  // (pie chart could be own entity?)
  void _setPieChart() {
    setState(
      () {},
    );
  }

// This popup includes a more detailed breakdown of carbon emissions
// (you could use tabs or use a scrollable, etc. to fit more visuals)
  Widget _buildEmissionsPopup(BuildContext context, Color boxColor) {
    String getMaxEmission() {
      var value = 0.0;
      dynamic key;

      _pieChartCategories.forEach((k, v) {
        if (v > value) {
          value = v;
          key = k;
        }
      });
      return key;
    }

    return Dialog(
      backgroundColor: boxColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 535,
        child: Column(
          children: <Widget>[
            const Padding(padding: EdgeInsets.all(8)),
            PieDiagram(),
            const Padding(padding: EdgeInsets.all(8)),
            const Text(
                "The category where most of your consumptions come from is: ",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const Padding(padding: EdgeInsets.all(2)),
            Text(getMaxEmission(),
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            const Padding(padding: EdgeInsets.all(8)),
            const Text("Some ways to reduce carbon emissions: ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                )),
          ],
        ),
      ),
    );
  }

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
              child: Text(
                "Welcome " + userFirstName + "!",
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
        childCount: 1,
      ),
    );
  }

  Widget _buildSecondBox(
      BuildContext context,
      double boxPadding,
      double boxElevation,
      Color boxColor,
      double progressCompleted,
      int progressLeft) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return ElevatedButton(
            child: Container(
              padding: EdgeInsets.all(boxPadding),
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // Use the minimum space necessary to fit all widgets
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Everything starts fartest left
                children: <Widget>[
                  Text(
                    "You are " +
                        progressLeft.toString() +
                        " points away from your next leaf!",
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Divider(
                      color: boxColor), // Adds some room between these widgets
                  const Text(
                    "Answer More Questions",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Divider(color: boxColor),
                  ClipRRect(
                    // Used to make the bar round
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      backgroundColor: const Color.fromRGBO(180, 180, 180, 1),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.green),
                      value: progressCompleted,
                      minHeight: 5,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              showDialog(
                barrierDismissible:
                    false, // Users cannot click off the screen to close popup
                context: context,
                builder: (BuildContext context) {
                  return const QuestionPopup();
                },
              );
            },
            style: ElevatedButton.styleFrom(
              primary: boxColor,
              elevation: boxElevation,
              fixedSize: const Size(330, 145),
              padding: const EdgeInsets.all(0),
            ),
          );
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
          return ElevatedButton(
            child: Container(
              padding: EdgeInsets.all(boxPadding),
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // Use the minimum space necessary to fit all widgets
                children: <Widget>[
                  const Text(
                    "My Carbon Emissions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  PieDiagram(),
                ],
              ),
            ),
            onPressed: () {
              showDialog(
                barrierDismissible:
                    true, // User can click off the screen to close popup
                context: context,
                builder: (BuildContext context) =>
                    _buildEmissionsPopup(context, boxColor),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: boxColor,
              elevation: boxElevation,
              padding: const EdgeInsets.all(0),
            ),
          );
        },
        childCount: 1,
      ),
    );
  }

  Widget _buildFourthBox(BuildContext context, double boxPadding,
      double boxElevation, Color boxColor, String funFact) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Material(
            color: boxColor,
            elevation: boxElevation,
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              padding: EdgeInsets.all(boxPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Fun Fact of the Day',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    funFact,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Divider(color: boxColor),
                  Row(
                    children: <Widget>[
                      const Spacer(),
                      TextButton(
                        child: const Text('Learn More'),
                        onPressed: () {
                          Navigator.pushNamed(context, '/learn_more');
                        },
                        style: TextButton.styleFrom(
                          elevation: 5,
                          primary: Colors.white,
                          fixedSize: const Size(146, 42),
                          backgroundColor: const Color.fromRGBO(2, 152, 89, 1),
                        ),
                      ),
                    ],
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
    return Center(
      // List of scrollable widgets
      // You can customize to space between each widget/ box
      child: CustomScrollView(
        slivers: <Widget>[
          SliverSafeArea(
            sliver: SliverPadding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 15, bottom: 0),
              sliver: _buildFirstBox(context, _boxPadding, _boxElevation,
                  _boxColor, _userFirstName),
            ),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 0),
            sliver: _buildSecondBox(context, _boxPadding, _boxElevation,
                _boxColor, _progressCompleted, _progressLeft),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 0),
            sliver:
                _buildThirdBox(context, _boxPadding, _boxElevation, _boxColor),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 25),
            sliver: _buildFourthBox(
                context, _boxPadding, _boxElevation, _boxColor, _funFact),
          ),
        ],
      ),
    );
  }
}
