import 'package:flutter/material.dart';
import 'package:green_peeps_app/homescreen/info_dialog.dart';
import 'package:green_peeps_app/homescreen/pie_diagram.dart';

import 'package:green_peeps_app/homescreen/welcome_box.dart';
import 'package:green_peeps_app/homescreen/articles_box.dart';
import 'package:green_peeps_app/homescreen/progress_box.dart';
import 'package:green_peeps_app/homescreen/daily_questions_box.dart';
import 'package:green_peeps_app/homescreen/daily_habits_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_peeps_app/homescreen/pie_diagram_box.dart';

// Database Information (variables)
String userFirstName = "";
Map<String, double> carbonEmissions = {
  'electricity': 0.0,
  'food': 0.0,
  'transportation': 0.0
};
const String _funFact = "Prawns are cannibals";

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
            Text('',
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
                  Row(
                    children: const <Widget>[
                      Text(
                        "My Carbon Emissions",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Spacer(),
                      Icon(
                        Icons.info_outline_rounded,
                        color: Colors.black,
                        size: 30,
                      ),
                    ],
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

  void _reverseSeeInfo(){
    setState((){
      _seeInfo = !_seeInfo;
    });
  }

  bool _seeInfo = false;
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Center(
      // List of scrollable widgets
      // You can customize to space between each widget/ box

      child: Scrollbar(
        controller: _controller,
        child: CustomScrollView(
          controller: _controller,
          slivers: const <Widget>[
            SliverSafeArea(
              sliver: SliverPadding(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 0),
                sliver: WelcomeBox(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 0),
              sliver: ProgressBox(),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 0),
              sliver: DailyQuestionsBox(),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 0),
              sliver: DailyLogsBox(),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 0),
              sliver: PieDiagramBox(),
            ),
            SliverPadding(
              padding:
                  EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 25),
              sliver: ArticlesBox(),
            ),
          ],
        ),
      ),
    );
  }
}
