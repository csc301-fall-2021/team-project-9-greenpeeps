import 'package:flutter/material.dart';
import 'package:green_peeps_app/homescreen/question_popup.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_peeps_app/homescreen/pie_diagram.dart';

import 'package:green_peeps_app/homescreen/first_box.dart';
import 'package:green_peeps_app/homescreen/resources_box.dart';
import 'package:green_peeps_app/homescreen/second_box.dart';

// Database Information (variables)
String userFirstName = "";
Map<String, double> carbonEmissions = {
  'electricity': 0.0,
  'food': 0.0,
  'transportation': 0.0
};
const String _funFact =
    "Did you know that some house centipedes are poisonous. Additionally, house centipedes can sometimes regenerate their legs if they have been cut off. Trust me, I know from experience!";

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

// This popup includes a more detailed breakdown of carbon emissions
// (you could use tabs or use a scrollable, etc. to fit more visuals)
  Widget _buildEmissionsPopup(BuildContext context, Color boxColor) {
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
            const Text("Placeholder",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
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
                useRootNavigator: false,
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

  /*Widget _buildFourthBox(BuildContext context, double boxPadding,
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
  }*/

  @override
  Widget build(BuildContext context) {
    return Center(
      // List of scrollable widgets
      // You can customize to space between each widget/ box
      child: CustomScrollView(
        slivers: <Widget>[
          const SliverSafeArea(
            sliver: SliverPadding(
              padding: EdgeInsets.only(
                  left: 30, right: 30, top: 15, bottom: 0),
              sliver: FirstBox(),
            ),
          ),
          const SliverPadding(
            padding:
                EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 0),
            sliver: SecondBox(),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 0),
            sliver:
                _buildThirdBox(context, _boxPadding, _boxElevation, _boxColor),
          ),
          const SliverPadding(
            padding:
                EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 25),
            sliver: ResourcesBox(),
          ),
        ],
      ),
    );
  }
}
